#!/usr/bin/env python
# Speed Tester (mostly for check_mk)
#
import pyspeedtest

UPAlert = 20971520 # Alert if the Upload speed is less than...
DLAlert = 125829120 # Alert if the Download speed is less than...
PAlert = 2.5 # Alert is ping time is greater than...

speeds = pyspeedtest.SpeedTest()
speed_result = {'ping': speeds.ping(), 'download': speeds.download(), 'upload': speeds.upload()}
ping_result = 0
upload_result = 0
download_result = 0
ping_resulttxt = 'OK'
upload_resulttxt = 'OK'
download_resulttxt = 'OK'
if speed_result['download'] < DLAlert:
    download_result = 1
    download_resulttxt = 'Warning'
if speed_result['upload'] < UPAlert:
    upload_result = 1
    upload_resulttxt = 'Warning'
if speed_result['ping'] > PAlert:
    ping_result = 1
    ping_resulttxt = 'Warning'

pretty_up = pyspeedtest.pretty_speed(speed_result['upload'])
pretty_down = pyspeedtest.pretty_speed(speed_result['download'])
print "%s Bandwidth_ping ping=%s %s - ping time is %s" % (ping_result, speed_result['ping'], ping_resulttxt, speed_result['ping'])
print "%s Bandwidth_upload speed=%s %s - Upload speed is %s" % (upload_result, speed_result['upload'], upload_resulttxt, pretty_up)
print "%s Bandwidth_download speed=%s %s - Download speed is %s" % (download_result, speed_result['download'], download_resulttxt, pretty_down)

