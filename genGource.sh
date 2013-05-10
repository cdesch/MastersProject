#!/bin/sh

gource -1280x720 --title "LeapMotion Masters Project" --hide date,dirnames,filenames -o gource.ppm
ffmpeg -y -r 60 -f image2pipe -vcodec ppm -i gource.ppm -vcodec libx264 -preset ultrafast -pix_fmt yuv420p -crf 1 -threads 0 -bf 0 gource.mp4