import os

# List of target IPs
targets = [
    "172.29.33.65",
    "203.19.19.1",
    "172.29.33.1",
    "203.19.19.33",
    "203.19.19.81",
    "203.19.19.65",
    "203.19.19.97",
]

print("Pinging all targets from Scorpius...\n")

for ip in targets:
    print(f"Pinging {ip}...")
    os.system(f"ping -n 3 {ip}")
    print()

print("All pings completed!")
