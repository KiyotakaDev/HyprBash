#!/bin/bash

echo -e "\e[1;47;30mTHIS IS NEEDED FOR PROPER WORKING!\e[0m\n"
for i in {15..1}; do
  echo -ne "\e[1;47;30mREBOOTING IN $i SECONDS..\e[0m\r"
  sleep 1
done

echo -e "\e[1;47;30m[REBOOTING NOW!]\e[0m"
reboot
