#!/bin/bash

# need this for the cronjob
TOOLS=/home/id/Projects/tools
IMG_DIR=/home/id
#source /home/id/.bash_profile
QUERY=$(date +"%A, %B %d")
NOUN=$(curl https://www.random-ize.com/noun/nou-f.php)
# consider using '-R day' flag to get images from today :D
/usr/local/bin/googliser -p "$QUERY $NOUN" -L -a wide -m 4mp -n 1 -o $IMG_DIR # it goes into $HOME
URL=$(head -n 1 $IMG_DIR/image.links.list)
wget -O /home/id/Downloads/image.today $URL

echo "found url: $URL"

rm $IMG_DIR/image.links.list

# get the current active socket, for cronjob
export SWAYSOCK=/run/user/$(id -u)/sway-ipc.$(id -u).$(pgrep -x sway).sock

# show the background image
sway output DP-1 bg /home/id/Downloads/image.today fill
sway output DVI-D-1 bg /home/id/Downloads/image.today fill
sway output DVI-D-2 bg /home/id/Downloads/image.today fill
#sway output HDMI-A-1 bg /home/id/Downloads/image.today fill

# Split the background up into 4 pieces
#

# I stole these values from ~/.config/sway/config

# total screen image. The '^' stands for 'minimum values of width and height given, aspect ratio preserved'
#convert -gravity center -resize 4740x2340^ /home/id/Downloads/image.today /home/id/Downloads/image_today.png
# individual cropings
#convert -crop 1440x900+1600+0 /home/id/Downloads/image_today.png /home/id/Downloads/image_today_1.png
#convert -crop 1920x1080+0+960 /home/id/Downloads/image_today.png /home/id/Downloads/image_today_2.png
#convert -crop 900x1440+1920+900 /home/id/Downloads/image_today.png /home/id/Downloads/image_today_3.png
#convert -crop 1920x1080+2820+900 /home/id/Downloads/image_today.png /home/id/Downloads/image_today_4.png

# show the split background images
#sway output HDMI-A-1 bg /home/id/Downloads/image_today_1.png fill
#sway output DVI-D-2 bg /home/id/Downloads/image_today_2.png fill
#sway output DVI-D-1 bg /home/id/Downloads/image_today_3.png fill
#sway output DP-1 bg /home/id/Downloads/image_today_4.png fill

