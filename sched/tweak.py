from email.utils import getaddresses

s = open('emails.txt').read().split("\n")
for name, addr in getaddresses(s):
    print(f"{addr} {name}".strip())
