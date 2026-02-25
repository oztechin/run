#python /workspace/kohya_ss/setup_accelerate.py
#cd /workspace/kohya_ss
#source venv/bin/activate
#unset LD_LIBRARY_PATH

# LOG DOSYASI
#LOGFILE="/workspace/kohya_gui.log"

# GUI + LOG
#./gui.sh --listen=0.0.0.0 --share --noverify --server_port 7860 2>&1 | tee -a "$LOGFILE"

LOGFILE="/workspace/kohya_gui.log"

apt update --yes

yes | apt install python3.10 python3.10-venv python3.10-dev

yes | apt-get install python3.10-tk

cd /workspace

mv kohya_ss/setup_accelerate.py /workspace/

rm -rf kohya_ss

git clone https://github.com/bmaltais/kohya_ss.git

cd kohya_ss

mv /workspace/setup_accelerate.py  /workspace/kohya_ss/

git reset --hard

git pull

git clone https://github.com/kohya-ss/sd-scripts

cd sd-scripts

git reset --hard

git checkout sd3

git reset --hard

git pull

cd ..

python3.10 -m venv venv

source venv/bin/activate

python -m pip install --upgrade pip

pip install hf_transfer
pip install xformers
pip install -r requirements.txt

cd sd-scripts

pip install -r requirements.txt
 
cd ..

python setup_accelerate.py
 
unset LD_LIBRARY_PATH
./gui.sh --listen=0.0.0.0 --share --noverify --server_port 7860 2>&1 | tee -a "$LOGFILE"
