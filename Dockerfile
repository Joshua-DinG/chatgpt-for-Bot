FROM python:3.11.2-slim-bullseye

ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update && \
    apt-get install --no-install-recommends -yq xvfb git subversion binutils qtbase5-dev wkhtmltopdf ffmpeg nano tree net-tools iproute2 && \
    (strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5 || true) && \
    apt-get remove --purge -yq binutils && \
    apt-get clean && \
    apt-get autoremove --purge -y && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
RUN git clone -b browser-version https://github.com/lss233/chatgpt-mirai-qq-bot  && \
    mv chatgpt-mirai-qq-bot/* chatgpt-mirai-qq-bot/.[!.]* /app && \
    pip3 install --no-cache-dir -r requirements.txt && pip cache purge && \
    rm -rf chatgpt-mirai-qq-bot

CMD ["python3","/app/bot.py"]
