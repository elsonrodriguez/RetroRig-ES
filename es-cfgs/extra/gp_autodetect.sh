#!/bin/bash

# Project RetroRig: https://github.com/ProfessorKaos64/RetroRig
#
# This script detects a change of the amount of available GP controller. 
# If such a change was detected, it notifies EmulationStation.
#
# If enabled, it will start RetroRig automatically 
# for the first game controller being switched on.
#
# Author: Jens-Christian, aka  beaumanvienna/JC
# Author: Michael DeGuzis, aka  PK
#
# Revision: 20141030, JC, support for GP / USB and auto start EmulationStation function
# Revision: 20141229, PK, this will need overhauled for EmulationStation if need be

autostartES_GP_USB=enabled
autostartES_GP_BT=enabled

GP_BT_controllerAvailable=`cat /proc/bus/input/devices | egrep -w "PLAYSTATION(R)3 Controller|Xbox"`
GP_USB_controllerAvailable=`lsusb | egrep -w "PlayStation 3 Controller|Xbox"`

while [ 0 ]
do
  oldGP_BT_controllerAvailable=$GP_BT_controllerAvailable
  oldGP_USB_controllerAvailable=$GP_USB_controllerAvailable  
  
  #check for GP / USB controller
  
  GP_USB_controllerAvailable=`lsusb | egrep -w "PlayStation 3 Controller|Xbox"`
  if [ "$GP_USB_controllerAvailable" != "$oldGP_USB_controllerAvailable" ]; then
    echo "[begin:] GP / USB controller changed"
    
    #first attempt
    service xboxdrv stop
    killall -9 xboxdrv
    service xboxdrv start

    #second attempt
    service xboxdrv stop
    killall -9 xboxdrv
    service xboxdrv start
    
    #auto start EmulationStation for first controller being switched on
    if [ "$autostartES_GP_USB" == "enabled" ]; then
      echo "auto start function"
      autostarted=false
      
      if [ -z "$setup_running" ]; then
        #retrorig-setup-es is not running
        echo "retrorig-setup-es is not running"
        
        if [ -z "$oldGP_USB_controllerAvailable" ]; then
          #first controller was switched on
          echo "first controller was switched on"
          
          es_running=`ps ax |egrep -w emulationstation |egrep -wv grep`
          if [ -z "$es_running" ]; then
            # ES not running yet
            echo "EmulationStation not running yet"
        
            # get user name
            user=`ps aux |grep "/bin/dbus-daemon --config-file"|egrep -wv grep|cut -f 1 -d " "`
        
            export export DISPLAY=:0.0
            echo "auto starting RetroRig-ES for user $user"
            sudo -u $user -g $user -s /usr/share/applications/startRetroES.sh &
            autostarted=true
            
          else
            echo "RetroRig-ES *not* started automatically: EmulationStation already running, EmulationStation_running="$es_running
          fi
        else
          echo "RetroRig-ES *not* started automatically: first controller not switched on, oldGP_USB_controllerAvailable="$oldGP_USB_controllerAvailable
        fi
      else
        echo "RetroRig-ES *not* started automatically: setup_running="$setup_running
      fi
    
      #diagnostic message
      sleep 2
      if [ "$autostarted" == "true" ]; then
        if [ -n "$(ps ax |grep emulationstation | egrep -wv grep)" ]; then
          echo "RetroRig-ES sucessfully started"
        else
          echo "attempt to start RetroRig-ES failed"
        fi
      fi
      
    else
      echo "auto start function disabled"
    fi
    
    #Avoid starting EmulationStation after USB is unplugged.
    #For some reasons the game controller connects via
    #BT after being unplugged from USB
    autostartES_GP_BT=enabled
    echo "[end:] GP / USB controller changed"
  fi
  
  #check for GP / Bluetooth controller
  
  GP_BT_controllerAvailable=`cat /proc/bus/input/devices | egrep -w "PLAYSTATION(R)3 Controller|Xbox"`
  if [ "$GP_BT_controllerAvailable" != "$oldGP_BT_controllerAvailable" ]; then
    echo "[begin:] GP / Bluetooth controller changed"
  
    #auto start EmulationStation for first controller being switched on
    if [ "$autostartES_GP_BT" == "enabled" ]; then
      echo "auto start function"
      autostarted=false
      setup_running=`ps ax |grep retrorig-es-setup| egrep -wv grep`
      
      if [ -z "$setup_running" ]; then
        #retrorig-setup is not running
        echo "retrorig-setup is not running"
        
        if [ -z "$oldGP_BT_controllerAvailable" ]; then
          #first controller was switched on
          echo "first controller was switched on"
      
          es_running=`ps ax |grep emulationstation`
          if [ -z "$es_running" ]; then
            # EmulationStation not running yet
            echo "EmulationStation not running yet"
        
            # get user name
            user=`ps aux |grep "/bin/dbus-daemon --config-file"|egrep -wv |cut -f 1 -d " "`
        
            export export DISPLAY=:0.0
            echo "auto starting RetroRig-ES for user $user"
            sudo -u $user -g $user -s /usr/share/applications/startRetroES.sh &
            autostarted=true
          else
            echo "RetroRig-ES *not* started automatically: EmulationStation already running, EmulationStation_running="$es_running
          fi
        else
          echo "RetroRig-ES *not* started automatically: first controller not switched on, oldGP_BT_controllerAvailable="$oldGP_BT_controllerAvailable
        fi
      else
        echo "RetroRig-ES *not* started automatically: setup_running="$setup_running
      fi
    
      #diagnostic message
      sleep 2
      if [ "$autostarted" == "true" ]; then
        if [ -n "$(ps ax | grep emulationstation |egrep -wv)" ]; then
          echo "RetroRig-ES sucessfully started"
        else
          echo "attempt to start RetroRig-ES failed"
        fi
      fi
      
    else
      echo "auto start function disabled"
    fi
    
    echo "[end:] GP / Bluetooth controller changed"
  fi
  sleep 1
done

