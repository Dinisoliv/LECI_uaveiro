import socket

def main():
    udp_s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    udp_s.bind(("127.0.0.1", 1234))

    addr_list = []

    while True:
        b_data, addr = udp_s.recvfrom(4096)
        print(b_data.decode("utf-8"))

        if addr not in addr_list: 
            addr_list.append(addr)

        for dst_addr in addr_list: 
            udp_s.sendto(b_data.upper(), dst_addr)

    udp_s.close()

main()
