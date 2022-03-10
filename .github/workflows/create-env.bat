set PATH=C:\Miniconda;C:\Miniconda\Scripts;C:\Miniconda3\Library\bin;%PATH%
conda create -n aqtenv -y
call conda.bat activate aqtenv
pip install aqtinstall
conda info --envs