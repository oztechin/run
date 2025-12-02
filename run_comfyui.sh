cd /workspace/ComfyUI/
git pull --rebase --autostash
source venv/bin/activate
python main.py --listen 0.0.0.0 --port 6006 --use-sage-attention
