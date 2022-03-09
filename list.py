import os

print(__file__)

with open("list.txt", 'w', encoding='utf-8') as f:
    for root, dirs, files in os.walk("C:\\"):
        for name in files:
            try:
                f.write(os.path.join(root,name) + "\n")
            except UnicodeEncodeError:
                pass

