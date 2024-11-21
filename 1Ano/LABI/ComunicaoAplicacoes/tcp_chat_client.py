import socket
import select
import sys


def main():
    tcp_s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    tcp_s.bind(("127.0.0.1", 0))
    tcp_s.connect(("127.0.0.1", 1234))
    while True:
        rsocks = select.select([tcp_s, sys.stdin], [], [])[0]
        for socks in 




#    while True:
 #       rsocks = select.select([tcp_s, sys.stdin, ], [], [])[0]
  #      for sock in rsocks:
   #         if sock == tcp_s:
    #            b_data, addr = tcp_s.recvfrom(4096)
     #           sys.stdout.write("%s\n" % b_data.decode("utf-8"))
      #      elif sock == sys.stdin:
       #         str_data = sys.stdin.readline()
        #        tcp_s.sendto(str_data.encode("utf-8"), server_addr)
    #tcp_s.close()
        

main()