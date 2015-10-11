#!/usr/bin/env python
# -*- coding: utf-8 -*-
# code license 3 clause BSD
# author, Will Skora

# todo: PROGRESS bar http://stackoverflow.com/questions/15644964/python-progress-bar-and-downloads/15645088#15645088 
# todo: move the older versions into my directory of older josm versions

# downloads the newest compiled version of JOSM (called 'latest') and names it with the current . 
# to run JOSM in your console, go to directory of JOSM, and do: java -jar nameofjosmfile

from bs4 import BeautifulSoup
import urllib
import urllib2
import re 

bpage = urllib2.urlopen("http://josm.openstreetmap.de")
soupp = BeautifulSoup(bpage.read())

# print(soupp.find(string=re.compile("development version"))) works!

# print(soupp.find("a", string=re.compile("development version"))) works. 

tehvar = soupp.find("a", string=re.compile("development version")) 

# next_sibling will find whatever string immediately follows tehvar
# remove the first characters and last 2 characters of it

josmversion = tehvar.next_sibling[2:-2]; 

print('The newest version of JOSM is ' + tehvar.next_sibling[2:-2]); 

# assemble the josm file name since I can't figure out how to use a variable 
# within the file name
josmfilename = "josm" + josmversion+ ".jar"

# yeah, urllib2 sounds like it's a pain in the arse for most things but 
# requests doesn't make it simple to download a binary file, so I used urllib 

mynewjosm = urllib.URLopener()
mynewjosm.retrieve("https://josm.openstreetmap.de/josm-latest.jar", josmfilename) 

print 'Download Finished' 




 

