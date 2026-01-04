cd /workspace/ai-toolkit
#python -m venv venv
source venv/bin/activate
git pull
pip install -r requirements.txt
cd ui
npm run build_and_start 2>&1 | tee -a "/workspace/ait.log"
