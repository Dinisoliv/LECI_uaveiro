import socket
import signal
import sys

def signal_handler(sig, frame):
    print('\nExiting game!')
    sys.exit(0)

signal.signal(signal.SIGINT, signal_handler)
print('Press Ctrl+C to exit...')

ip_addr = "127.0.0.1"
tcp_port = 5005

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

try:
    sock.connect((ip_addr, tcp_port))
    print("Connected to the game server!")

    while True:
        server_message = sock.recv(4096).decode()
        if not server_message:
            print("Disconnected from server.")
            break
        print(server_message, end="")  # Prompt from server
        if server_message.strip().endswith(":"):
            user_input = input()
            sock.send(user_input.encode())
except (socket.timeout, socket.error):
    print('Connection error. Exiting...')
finally:
    sock.close()
