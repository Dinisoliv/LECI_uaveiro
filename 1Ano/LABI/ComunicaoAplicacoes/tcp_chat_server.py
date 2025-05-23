import socket
import select

def main():
    tcp_s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    tcp_s.bind(("127.0.0.1", 1234))
    tcp_s.listen(10)
    connections = []

    connections.append(tcp_s)
    print("Chat server has started")

    while True:
        read_sockets = select.select(connections, [], [])[0]

        for sock in read_sockets:
            if sock == tcp_s:
                client_s, addr = tcp_s.accept()
                connections.append(client_s)
                print("Client connected %s" % str(addr))
            else:
                try:
                    data = sock.recv(4096)
                    if len(data) != 0:
                        print("Fom client %s" % str(sock.getpeername()))
                        print("Got data: " + data)
                    else:
                        print("Client disconnected %s" % str(sock.getpeername))
                        sock.close()
                        connections.remove(sock)
                        break
                    
                    message = "<Fom client: " + str(sock.getpeername) + "> "
                    message = message.encode("utf-8") + data.upper()

                    for client in connections:
                        if client != tcp_s:
                            client.send(message)

                except:
                    print("Client socket error: %s" % str(addr))
                    sock.close()
                    connections.remove(sock)
                    continue

    for sock in connections: sock.close()

main()