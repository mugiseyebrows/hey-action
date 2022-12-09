@echo off
rem This file is generated from main.pbat, all edits will be lost
set PATH=C:\Miniconda3;C:\Miniconda3\Scripts;%PATH%
python -m pip install mugicli
pyfind -maxdepth 2 C:\ > c.txt
pyfind "C:\Program Files" "C:\Program Files (x86)" > program-files.txt


