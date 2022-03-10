set PATH=C:\Miniconda;C:\Miniconda\Scripts;C:\Miniconda3\Library\bin;%PATH%
conda create -n aqtenv -y
conda init cmd.exe
conda activate aqtenv
pip install aqtinstall
conda info --envs