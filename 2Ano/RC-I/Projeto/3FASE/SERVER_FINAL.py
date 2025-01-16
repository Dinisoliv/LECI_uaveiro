import socket
import threading
import signal
import sys
import random
import time
import math
import select

# Signal handler for clean exit
def signal_handler(sig, frame):
    global is_running
    print('\nServer shutting down...')
    is_running = False  # Stop all threads

    # Close the server socket to stop accepting new connections
    server.close()

    # Close all client sockets
    with lock:
        for state in client_states.values():
            try:
                state["socket"].close()
            except socket.error:
                pass
    sys.exit(0)

signal.signal(signal.SIGINT, signal_handler)

# Global running flag
is_running = True

# Constants
CLIENT_TIMEOUT = 60  # Maximum idle time in seconds
CHECK_INTERVAL = 5   # Interval to check for inactive clients

# Dictionary to track client states
client_states = {}
lock = threading.Lock()  # Lock for thread-safe access to `client_states`
leaderboard = {}  # Dictionary to track scores by player name

def print_connections():
    with lock:
        connections = ", ".join([f"{state['name']} ({address})" for address, state in client_states.items()])
    print(f"Current connections: {connections if connections else 'No active connections.'}")

#Returns a formatted leaderboard showing players, their average points per game, and games played.
def get_leaderboard():    
    with lock:
        if leaderboard:
            # Sort leaderboard by average points per game in descending order
            sorted_leaderboard = sorted(
                leaderboard.items(),
                key=lambda item: item[1]['points'] / item[1]['games'] if item[1]['games'] > 0 else 0,
                reverse=True
            )

            # Get the top player for highlighting
            if sorted_leaderboard:
                top_player, _ = sorted_leaderboard[0]

            # Format the leaderboard
            leaderboard_data = "\n".join(
                [
                    f"{'*' if name == top_player else ''}{name}: "
                    f"{data['points'] / data['games']:.2f} points (Games: {data['games']})"
                    for name, data in sorted_leaderboard
                    if data['games'] > 0
                ]
            )
        else:
            leaderboard_data = "No leaderboard data yet."

    return f"Leaderboard:\n{leaderboard_data}"

def safe_thread(func):
    def wrapper(*args, **kwargs):
        try:
            func(*args, **kwargs)
        except Exception as e:
            print(f"Error in thread {func.__name__}: {e}")
    return wrapper

# Handle each client's connection
@safe_thread
def handle_client_connection(client_socket, address): 
    print(f"Client connected: {address}")
    try:
        # Initialize client state
        while True:
            client_socket.send("Enter your name: ".encode())
            player_name = client_socket.recv(1024).decode().strip()

            with lock:
                if player_name in [state["name"] for state in client_states.values()]:
                    client_socket.send("This name is already taken. Please choose another one.\n".encode())
                else:
                    break

        # Add player to the leaderboard if not already present
        with lock:
            if player_name not in leaderboard:
                leaderboard[player_name] = {"points": 0, "games": 0}

        while True:  # Main game loop for multiple rounds
            # Ask client for the maximum number to guess
            client_socket.send("Enter the maximum number you want to guess: ".encode())
            max_number_input = client_socket.recv(1024).decode().strip()
            
            if not max_number_input.isdigit():
                client_socket.send("Enter a valid number!".encode())
                continue
            max_number = int(max_number_input)

            # Ensure the max_number is at least 1
            if max_number < 1:
                client_socket.send("The maximum number must be at least 1. Setting it to 100.\n".encode())
                max_number = 100

            # Calculate the max guesses based on log2(max_number), rounded up
            max_guesses = math.ceil(math.log2(max_number)) - 1

            client_socket.send(f"The maximum number of guesses allowed is {max_guesses} for a target number between 1 and {max_number}.\n".encode())

            # Generate a random target number between 1 and max_number
            target_number = random.randint(1, max_number)

            # Initialize the client's state, including previous_diference
            with lock:
                client_states[address] = {
                    "name": player_name,
                    "guesses": 0,
                    "target": target_number,
                    "last_active": time.time(),
                    "socket": client_socket,
                    "max_guesses": max_guesses,
                    "previous_diference": max_number,  # Set initial difference to the largest possible value
                }

            print(f"Player '{player_name}' from {address} is ready to play, with number to guess {target_number} and max guesses {max_guesses}.")

            # Play the game
            while True:
                with lock:
                    if address not in client_states:
                        break  # Exit if client was removed

                # Increment guesses count
                with lock:
                    current_guesses = client_states[address]["guesses"]
                    max_guesses = client_states[address]["max_guesses"]

                # Check if the client exceeded the max guesses
                if current_guesses >= max_guesses:
                    client_socket.send(f"Sorry, you've reached the maximum number of guesses ({max_guesses}). The correct number was {target_number}. Game over.\n".encode())
                    print(f"Player '{player_name}' from {address} exceeded the max guesses of {max_guesses}. The correct number was {target_number}. Game over.")
                    break

                client_socket.send("Guess the number: ".encode())
                try:
                    guess = client_socket.recv(1024).decode().strip()
                    try:
                        guess = int(guess)  # Convert the guess to an integer
                        difference = abs(target_number - guess)  # Now subtraction will work
                    except ValueError:
                        client_socket.send("Invalid input. Please enter a number.\n".encode())
                        continue
                    if not guess:  # Handle empty message
                        raise socket.error("Client disconnected.")
                except socket.error:
                    print(f"Client {address}, {player_name} disconnected unexpectedly.")
                    break
                
                # Update last activity time
                with lock:
                    if address in client_states:
                        client_states[address]["last_active"] = time.time()

                # Increment guesses count
                with lock:
                    client_states[address]["guesses"] += 1
                    current_guesses = client_states[address]["guesses"]

                # Compare guess with target number
                if guess == client_states[address]["target"]:
                    
                    # Calculate points
                    points = max_number / current_guesses

                    # Update leaderboard
                    with lock:
                        leaderboard[player_name]["points"] += points

                    client_socket.send(f"Correct! You guessed it in {current_guesses} tries.\n".encode())
                    print(f"Player '{player_name}' from {address} won in {current_guesses} tries.")
                    break

                # Retrieve and update the previous difference
                with lock:
                    previous_diference = client_states[address]["previous_diference"]

                if difference < previous_diference:
                    if guess < client_states[address]["target"]:
                        client_socket.send("Too low! Getting closer! Try Again.\n".encode())       
                    else:
                        client_socket.send("Too high! Getting closer! Try Again.\n".encode())
                else:
                    if guess < client_states[address]["target"]:
                        client_socket.send("Too low! Getting further away! Try Again.\n".encode())
                    else:
                        client_socket.send("Too high! Getting further away! Try Again.\n".encode())

                # Update the previous difference in the client state
                with lock:
                    client_states[address]["previous_diference"] = difference

            # Update number of games
            with lock:
                leaderboard[player_name]["games"] += 1

            # Send leaderboard to client
            client_socket.send(get_leaderboard().encode())

            client_socket.send("\nDo you want to play again? Please type 'yes' or 'no': ".encode())
            try:
                play_again = client_socket.recv(1024).decode().strip().lower()
                if play_again == "yes" or play_again == "y":
                    continue  # Restart the game loop
                else:
                    break  # Exit the game loop
            except socket.error:
                print(f"Client {address}, {player_name} disconnected unexpectedly.")
                break

    except (socket.error, socket.timeout):
        print(f"Error with client {address}. Disconnecting.")
    finally:
        print(f"Game over for {address}. Cleaning up...")
        with lock:
            if address in client_states:
                try:
                    del client_states[address]
                except KeyError:
                    pass
        client_socket.close()

    #chat_option(client_socket, address)

    print(f"Client connected: {address}")
    try:
        # Initialize client state
        while True:
            client_socket.send("Enter your name: ".encode())
            player_name = client_socket.recv(1024).decode().strip()

            with lock:
                if player_name in [state["name"] for state in client_states.values()]:
                    client_socket.send("This name is already taken. Please choose another one.\n".encode())
                else:
                    break

        # Add player to the leaderboard if not already present
        with lock:
            if player_name not in leaderboard:
                leaderboard[player_name] = {"points": 0, "games": 0}

        while True:  # Main game loop for multiple rounds
            # Ask client for the maximum number to guess
            client_socket.send("Enter the maximum number you want to guess: ".encode())
            max_number_input = client_socket.recv(1024).decode().strip()
            
            if not max_number_input.isdigit():
                    client_socket.send("Enter a valid number!".encode())
                    continue
            max_number = int(max_number_input)

            previous_diference = max_number

            # Ensure the max_number is at least 1
            if max_number < 1:
                client_socket.send("The maximum number must be at least 1. Setting it to 100.\n".encode())
                max_number = 100

            # Calculate the max guesses based on log2(max_number), rounded up
            max_guesses = math.ceil(math.log2(max_number)) - 1

            client_socket.send(f"The maximum number of guesses allowed is {max_guesses} for a target number between 1 and {max_number}.\n".encode())

            # Generate a random target number between 1 and max_number
            target_number = random.randint(1, max_number)

            # Update client state with the calculated max guesses
            with lock:
                client_states[address] = {
                    "name": player_name,
                    "guesses": 0,
                    "target": target_number,
                    "last_active": time.time(),
                    "socket": client_socket,
                    "max_guesses": max_guesses,
                    "previous_distance": max_number,
                }

            print(f"Player '{player_name}' from {address} is ready to play, with number to guess {target_number} and max guesses {max_guesses}.")

            # Play the game
            while True:
                with lock:
                    if address not in client_states:
                        break  # Exit if client was removed

                                # Increment guesses count
                with lock:
                    current_guesses = client_states[address]["guesses"]
                    max_guesses = client_states[address]["max_guesses"]

                # Check if the client exceeded the max guesses
                if current_guesses >= max_guesses:
                    client_socket.send(f"Sorry, you've reached the maximum number of guesses ({max_guesses}). The correct number was {target_number}. Game over.\n".encode())
                    print(f"Player '{player_name}' from {address} exceeded the max guesses of {max_guesses}. The correct number was {target_number}. Game over.")
                    break

                client_socket.send("Guess the number: ".encode())
                try:
                    guess = client_socket.recv(1024).decode().strip()
                    try:
                        guess = int(guess)  # Convert the guess to an integer
                        difference = abs(target_number - guess)  # Now subtraction will work
                    except ValueError:
                        client_socket.send("Invalid input. Please enter a number.\n".encode())
                        continue
                    if not guess:  # Handle empty message
                        raise socket.error("Client disconnected.")
                except socket.error:
                    print(f"Client {address}, {player_name} disconnected unexpectedly.")
                    break
                
                # Update last activity time
                with lock:
                    if address in client_states:
                        client_states[address]["last_active"] = time.time()

                # Increment guesses count
                with lock:
                    client_states[address]["guesses"] += 1
                    current_guesses = client_states[address]["guesses"]

                # Validate input
                try:
                    guess = int(guess)
                except ValueError:
                    client_socket.send("Invalid input. Please enter a number.\n".encode())
                    continue

                # Compare guess with target number
                if guess == client_states[address]["target"]:
                    
                    # Calculate points
                    points = max_number / current_guesses

                    # Update leaderboard
                    with lock:
                        leaderboard[player_name]["points"] += points

                    client_socket.send(f"Correct! You guessed it in {current_guesses} tries.\n".encode())
                    print(f"Player '{player_name}' from {address} won in {current_guesses} tries.")
                    break

                # Retrieve and update the previous difference
                with lock:
                    previous_diference = client_states[address]["previous_diference"]

                if difference < previous_diference:
                    if guess < client_states[address]["target"]:
                        client_socket.send("Too low! Getting closer! Try Again.\n".encode())       
                    else:
                        client_socket.send("Too high! Getting closer! Try Again.\n".encode())
                else:
                    if guess < client_states[address]["target"]:
                        client_socket.send("Too low! Getting further away! Try Again.\n".encode())
                    else:
                        client_socket.send("Too high! Getting further away! Try Again.\n".encode())

                # Update the previous difference in the client state
                with lock:
                    client_states[address]["previous_diference"] = difference

            # Update number of games
            with lock:
                leaderboard[player_name]["games"] += 1

            # Send leaderboad to client
            client_socket.send(get_leaderboard().encode())

            client_socket.send("\nDo you want to play again? Please type 'yes' or 'no': ".encode())
            try:
                play_again = client_socket.recv(1024).decode().strip().lower()
                if play_again == "yes" or play_again == "y":
                    continue  # Restart the game loop
                else:
                    break  # Exit the game loop
            except socket.error:
                print(f"Client {address}, {player_name} disconnected unexpectedly.")
                break

    except (socket.error, socket.timeout):
        print(f"Error with client {address}. Disconnecting.")
        #traceback.print_exc()
    finally:
        print(f"Game over for {address}. Cleaning up...")
        with lock:
            if address in client_states:
                try:
                    del client_states[address]
                except KeyError:
                    pass
        client_socket.close()

# Background thread to monitor inactive clients
def monitor_inactive_clients():
    while is_running:
        time.sleep(CHECK_INTERVAL)
        current_time = time.time()
        with lock:
            inactive_clients = [
                address for address, state in client_states.items()
                if current_time - state["last_active"] > CLIENT_TIMEOUT
            ]
            for address in inactive_clients:
                print(f"Disconnecting inactive client: {address}")
                try:
                    client_states[address]["socket"].close()
                except socket.error:
                    pass
                if address in client_states:
                    del client_states[address]

# Handle each client's connection
def handle_server_input():
    global is_running
    
    print("\nPress '1' to show current connections, '2' to display leaderboard, or 'q' to quit the server.")
    
    while is_running:
        # Use select for non-blocking input with a timeout
        ready, _, _ = select.select([sys.stdin], [], [], 1)  # Wait 1 second for input
        if ready:
            command = sys.stdin.readline().strip()
            if command == "1":
                print_connections()
            elif command == "2":
                print(get_leaderboard())
            elif command == "q":
                print("Shutting down server...")
                signal_handler(None, None)
                break

# Main server setup
ip_addr = "0.0.0.0"
tcp_port = 5005

server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind((ip_addr, tcp_port))
server.listen(5)

print(f"Server listening on {ip_addr}:{tcp_port}")

# Start the inactivity monitor thread
monitor_thread = threading.Thread(target=monitor_inactive_clients, daemon=True)
monitor_thread.start()

# Start server input thread
server_input_thread = threading.Thread(target=handle_server_input, daemon=True)
server_input_thread.start()

# Accept and handle clients
try:
    while is_running:
        client_sock, address = server.accept()
        client_handler = threading.Thread(target=handle_client_connection, args=(client_sock, address), daemon=True)
        client_handler.start()
except KeyboardInterrupt:
    # Handling the server shutdown when interrupt occurs
    signal_handler(None, None)