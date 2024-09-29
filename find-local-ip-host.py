import socket

def discover_hosts():
    # 获取本机IP地址
    print(socket.gethostname())
    local_ip = socket.gethostbyname(socket.gethostname())

    print(local_ip)

    # 设置子网前缀长度为24位（默认情况下）
    #subnet_prefix = '192.168.' + '.'.join([str((int(x) & int('0xf', 16)) | (int('f', 16))) for x in local_ip.split('.')])[:-3]
    subnet_prefix = '192.168.101'
    print(subnet_prefix);

    # 遍历从1到255之间的每个数字作为最后一部分的IP地址
    for i in range(1, 10):
        ip = f"{subnet_prefix}.{i}"

        print(ip);

        try:
            hostname = socket.gethostbyaddr(ip)[0][0].decode()
            # hostname =socket.gethostname();

            print("Hostname:", hostname)
            print("IP Address:", ip)
            print("\n")
        except socket.herror as e:
            print("e:", e)
            pass
if __name__ == '__main__':
    discover_hosts()
