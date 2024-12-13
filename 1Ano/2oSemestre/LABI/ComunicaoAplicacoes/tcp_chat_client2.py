import socket
import select
import sys

def main():
    tcp_s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    tcp_s.bind(("127.0.0.1", 0))  # Binding to an available port
    server_addr = ("127.0.0.1", 1234)

    while True:
        # Using select to handle I/O on stdin and socket
        rsocks = select.select([tcp_s, sys.stdin], [], [])[0]
        for sock in rsocks:
            if sock == tcp_s:
                # Information received on the socket
                client_s, addr = tcp_s.accept()  # Accepting new connection
                print("Client connected %s" % str(addr))
                while True:
                    data = client_s.recv(4096)
                    if not data:
                        break
                    print("From client %s: %s" % (str(addr), data.decode("utf-8")))
                    str_data = input("You: ")
                    client_s.sendall(str_data.encode("utf-8"))
                print("Client disconnected %s" % str(addr))
                client_s.close()
            elif sock == sys.stdin:
                # Information received from keyboard
                str_data = sys.stdin.readline()
                tcp_s.sendto(str_data.encode("utf-8"), server_addr)  # Sending data to server
    tcp_s.close()

main()