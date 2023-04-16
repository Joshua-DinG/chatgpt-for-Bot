FROM python:3.11.2-slim-bullseye
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install --no-install-recommends -yq xvfb binutils qtbase5-dev wkhtmltopdf ffmpeg nano tree git && \
    (strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5 || true) && \
    apt-get remove --purge -yq binutils && \
    apt-get clean && \
    apt-get autoremove --purge -y && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
RUN git clone https://github.com/lss233/chatgpt-mirai-qq-bot . && \
    mv chatgpt-mirai-qq-bot/* chatgpt-mirai-qq-bot/.[!.]* . && \
    pip3 install -r requirements.txt && \
    rm -rf chatgpt-mirai-qq-bot

CMD ["/usr/bin/python3","/app/bot.py"]
