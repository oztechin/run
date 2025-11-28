apt install psmisc
cd /workspace/ComfyUI/venv
source bin/activate
cd /workspace/ComfyUI
python main.py --listen 0.0.0.0 --port 7860 --use-sage-attention