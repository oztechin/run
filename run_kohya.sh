python /workspace/kohya_ss/setup_accelerate.py
cd /workspace/kohya_ss
source venv/bin/activate
unset LD_LIBRARY_PATH

# LOG DOSYASI
LOGFILE="/workspace/kohya_gui.log"

# GUI + LOG
./gui.sh --listen=0.0.0.0 --share --noverify --port 7860 2>&1 | tee -a "$LOGFILE"