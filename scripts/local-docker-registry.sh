#!/usr/bin/sh

sudo docker run -d -p 5000:5000 --restart=always --name registry registry:2
