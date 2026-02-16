cd  /workspace

#git pull --rebase --autostash
#source venv/bin/activate
#pip install -r requirements.txt
#python main.py --listen 0.0.0.0 --port 6006 --use-sage-attention
 cd  /workspace

#git pull --rebase --autostash
#source venv/bin/activate
#
#python main.py --listen 0.0.0.0 --port 6006 --use-sage-attention



cd /workspace/ComfyUI
git pull

cd /workspace/ComfyUI/custom_nodes/ComfyUI-Manager
git pull

cd /workspace/ComfyUI/custom_nodes/RES4LYF
git pull

cd /workspace/ComfyUI/custom_nodes/ComfyUI-ReActor
git pull

cd /workspace/ComfyUI/custom_nodes/ComfyUI-Impact-Pack
git pull

cd /workspace/ComfyUI/custom_nodes/ComfyUI_IPAdapter_plus
git pull

cd /workspace/ComfyUI/custom_nodes/ComfyUI-GGUF
git pull

cd /workspace/ComfyUI
source venv/bin/activate
pip install -r requirements.txt

python main.py --listen 0.0.0.0 --port 6006 --use-sage-attention
