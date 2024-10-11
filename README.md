# cài đặt
## Chạy trên docker
```bash
docker run -it -p 5050:5050 akthangdz/tts1:latest /bin/bash -c "source .env/bin/activate && pip install --upgrade gradio && python vixtts_demo.py"
```
