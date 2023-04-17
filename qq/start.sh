#!/bin/bash

export DISPLAY=${DISPLAY:-:0}
XVFB_WHD=${XVFB_WHD:-1280x720x24}
XVFB_SCREEN=${XVFB_SCREEN:-0}


Xvfb $DISPLAY -ac -screen $XVFB_SCREEN $XVFB_WHD -nolisten tcp &

go-cqhttp -c config.yml
