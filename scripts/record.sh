############ The Clockwork PC Webcasting Script #################
#
# This script is the fruit of many hours of research into FFMPEG.
#
# You will need ffmpeg with x11grab, and a number of libraries that should be installed automatically.
#
# You will need a custom directory ~/Videos/Screencasts or change the output directory in the commands.
#
# You will also need to download and install the newest xcowsay from its homepage, 
# because the older xcowsay from the Ubuntu repositories (2010-08-31 at the time of writing) will not work with the --monitor option.
#
# The chained command creates THREE separate files: 
# x11grab for your desktop, 
# video4linux2 for your webcam, 
# alsa for your microphone or headset. 
# 
# This is very important to me because I use Openshot Video Editor, which cannot split audio and video yet, but can combine them very well.
# If this is not important to you, there are many fine commands that combine audio and video streams into a single file, so you don't have to use mine.
#
# However, this chained command will record everything synchronously, including webcam and audio.
#
# Enjoy! 
#
# Alexander,
# linux@clockworkpc.com.au
#
#
################################################## ###############

# Working on saving all the files into date-stamped bins,
# but for now they just pile up in Screencasts.

SCREEN_RES=1920x1080
CAM_RES=1024x768

#ffmpeg -f x11grab -r 30 -s $SCREEN_RES -i :0.0 -vcodec libx264 -preset superfast -crf 50 ~/Videos/Screencasts/bin_today/Screencast_on_$(date +%F_%A_at_%H:%M:%S).m4v
#&\
ffmpeg -f alsa -i pulse -f v4l2 -s $CAM_RES -i /dev/video0 -vcodec mpeg2video ~/Screencasts/bin_today/Webcam_on_$(date +%F_%A_at_%H:%M:%S).mpeg
#&\
#ffmpeg -f alsa -ac 2 -i pulse -acodec pcm_s16le ~/Videos/Screencasts/bin_today/Audio_on_$(date +%F_%A_at_%H:%M:%S).wav &\

################################################## ##########
#
# Add a cute talking cow.
#
# (Haven't worked out how to stop it from popping up before # the videos have finished recording)
#
## xcowsay --cow-size=large --time=3 --monitor=0 "Your video has been recorded "
#
################################################## ##########

