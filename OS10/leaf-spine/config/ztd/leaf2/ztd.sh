#!/bin/bash 
####################################################################
#  
# 
#            Example OS10 ZTD Provisioning Script   
# 
# 
#################################################################### 

########## UPDATE THE BELOW CONFIG VARIABLES ACCORDINGLY ########### 
########## ATLEAST ONE OF THEM SHOULD BE FILLED ####################

#IMG_FILE="http://192.168.1.9/ztd/leaf1/OS10.bin"
CLI_CONFIG_FILE="http://192.168.1.9/ztd/leaf2/cli_config" 
POST_SCRIPT_FILE="http://192.168.1.9/ztd/leaf2/post_script.py"

################### DO NOT MODIFY THE LINES BELOW ####################### 
sudo os10_ztd_start.sh "$IMG_FILE" "$CLI_CONFIG_FILE" "$POST_SCRIPT_FILE" 
########################      **END**     ###############################
