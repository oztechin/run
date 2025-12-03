apt install -y nodejs
mkdir -p /workspace 
cd /workspace 
git clone https://github.com/ostris/ai-toolkit.git
cd ai-toolkit
python -m venv venv
source venv/bin/activate
pip install --no-cache-dir torch==2.7.0 torchvision==0.22.0 torchaudio==2.7.0 --index-url https://download.pytorch.org/whl/cu126
pip install -r requirements.txt