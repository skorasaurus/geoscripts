#!/bin/bash

# code from
# http://wuhrr.wordpress.com/2009/09/10/simple-menu-with-bashs-select-command/

# Displays a list of files in current directory and prompt for which

# Set the prompt for the select command
PS3="Type a number or 'q' to quit: "
 
# Create a list of files to display
# maxdepth is levels of subfolders that find will search through
# name restricts it to only search GPX traces
fileList=$(find /media/gofer/Dropbox/1unprocessed -maxdepth 2 -name "*.gpx" -type f)
 
# Assigns each file a number, prompts user to select file 
# then asks user to select which location do you want to 
select fileName in $fileList; do
    if [ -n "$fileName" ]; then
echo "where location do you want your traces removed: home, svdp or cfb? (then press enter)"
read place;
        case "$place" in
home) 
#home 
    	gpsbabel -i gpx -f /media/gofer/Dropbox/1unprocessed/${fileName} \
       -x transform,wpt=trk,del \
       -x radius,distance=1.1K,lat=41.4344,lon=-81.69378,nosort,exclude \
       -x transform,trk=wpt,del \
       -o gpx -F /media/gofer/Dropbox/unprocessed/${fileName}-refined.gpx 
       ;; 
svdp)       
gpsbabel -i gpx -f /media/gofer/Dropbox/1unprocessed/${fileName}.gpx \
       -x transform,wpt=trk,del \
       -x radius,distance=0.7K,lat=41.488,lon=--81.648,nosort,exclude \
       -x transform,trk=wpt,del \
       -o gpx -F ${fileName}-refined.gpx 
       ;; 
#if cfb
cfb)
        gpsbabel -i gpx -f ${fileName} \
       -x transform,wpt=trk,del \
       -x radius,distance=1K,lat=41.56,lon=-81.573103,nosort,exclude \
       -x transform,trk=wpt,del \
       -o gpx -F ${fileName}-refined.gpx
       ;;
    esac   
    fi
    break
done