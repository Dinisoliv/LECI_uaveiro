def chat_option(client_socket, address):
    # Server asks the client if they want to chat
    chat_initiated = False
    client_socket.send("Press '0' to chat with another player or any other key to start the game: ".encode())
    start_option = client_socket.recv(1024).decode().strip()  # Get input from the client
    
    if start_option == '0':
        # Start chat session
        chat_initiated = True
        print("Chat initiated. You can send 3 messages or press 'q' to quit.")
        
        # Get other players' sockets to send messages
        other_players = {addr: state['socket'] for addr, state in client_states.items() if addr != address}
        message_count = 0
        
        while message_count < 3:
            # Ask client for a message
            client_socket.send(f"Message {message_count + 1}: ".encode())
            message = client_socket.recv(1024).decode().strip()
            
            if message == 'q':
                print("Exiting chat.")
                break
            
            print(f"You: {message}")  # Print the message from the client (optional for logging)
            
            # Relay the message to all other players
            for player_socket in other_players.values():
                try:
                    player_socket.sendall(f"Player {address} says: {message}".encode())
                except Exception as e:
                    print(f"Error sending message: {e}")
            
            message_count += 1
        # Exit chat and start the game after 3 messages or 'q'
    else:
        print("Starting the game without chat.")
