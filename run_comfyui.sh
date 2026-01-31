cd  /workspace

#git pull --rebase --autostash
#source venv/bin/activate
#pip install -r requirements.txt
#python main.py --listen 0.0.0.0 --port 6006 --use-sage-attention

#!/usr/bin/env bash
set -e

echo "===> ComfyUI Clean Installer (H100 + cu130 @ /workspace)"

BASE_DIR="/workspace"
COMFY_DIR="$BASE_DIR/ComfyUI2"

# 0) NVIDIA kontrol
echo "===> Checking NVIDIA driver..."
nvidia-smi || { echo "NVIDIA driver not found!"; exit 1; }

# 1) Sistem paketleri
echo "===> Installing system packages..."
apt update
apt install -y \
  python3.10 python3.10-venv python3-pip \
  git wget ffmpeg libgl1 libglib2.0-0 \
  build-essential

# 2) Eski kurulumu TEMİZLE
echo "===> Removing old ComfyUI at $COMFY_DIR ..."
rm -rf "$COMFY_DIR"
rm -rf ~/.cache/torch_extensions
rm -rf ~/.cache/pip

# 3) ComfyUI klonla
echo "===> Cloning ComfyUI into $COMFY_DIR ..."
cd "$BASE_DIR"
git clone https://github.com/comfyanonymous/ComfyUI.git ComfyUI2

cd "$COMFY_DIR"

# 4) Virtualenv oluştur
echo "===> Creating venv..."
python3.10 -m venv venv
source venv/bin/activate
pip install --upgrade pip setuptools wheel

# 5) CUDA 13.0 uyumlu PyTorch
echo "===> Installing PyTorch cu130..."
pip uninstall -y torch torchvision torchaudio || true
pip install torch torchvision torchaudio \
  --index-url https://download.pytorch.org/whl/cu130

# 6) PyTorch test
echo "===> Testing PyTorch CUDA..."
python - <<'EOF'
import torch
print("Torch:", torch.__version__)
print("CUDA available:", torch.cuda.is_available())
print("Torch CUDA:", torch.version.cuda)
print("GPU:", torch.cuda.get_device_name(0) if torch.cuda.is_available() else "N/A")
EOF

# 7) ComfyUI requirements
echo "===> Installing ComfyUI requirements..."
pip install -r requirements.txt

# 8) xformers (cu130)
echo "===> Installing xformers..."
pip uninstall -y xformers || true
pip install xformers --no-cache-dir \
  --index-url https://download.pytorch.org/whl/cu130 || \
pip install --pre xformers

# 9) Triton (stabil)
echo "===> Installing triton..."
pip uninstall -y triton || true
pip install triton==3.1.0

# 10) comfy-kitchen'i KESİN kaldır
echo "===> Removing comfy-kitchen if exists..."
pip uninstall -y comfy-kitchen || true

# 11) ComfyUI-Manager
echo "===> Installing ComfyUI-Manager..."
cd custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager.git || true
cd ..

# 12) Ortam değişkenleri (H100 stabilite)
echo "===> Setting environment flags..."
echo 'export COMFYUI_DISABLE_KITCHEN=1' >> ~/.bashrc
echo 'export COMFYUI_DISABLE_TRITON=1' >> ~/.bashrc

export COMFYUI_DISABLE_KITCHEN=1
export COMFYUI_DISABLE_TRITON=1

# 13) Cache temizliği
echo "===> Cleaning ComfyUI cache..."
rm -rf custom_nodes/.cache

# 14) Final mesaj
echo "========================================="
echo " ComfyUI installation COMPLETE!"
echo " Location: $COMFY_DIR"
echo " To start ComfyUI:"
echo "   cd $COMFY_DIR"
echo "   source venv/bin/activate"
echo "   python main.py --listen --port 6006"
echo "========================================="
