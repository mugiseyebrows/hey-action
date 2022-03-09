import os

print(__file__)

with open("list.txt", 'w', encoding='utf-8') as f:
    for root, dirs, files in os.walk("C:\\"):
        for f in files:
            f.write(os.path.join(root,f) + "\n")

