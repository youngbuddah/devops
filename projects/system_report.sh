 #!/bin/bash
  2  
  3 #First Project - System Info Report                                                                                                                      
  4  
  5 echo "__ System Report - $(date)"
  6 echo "--------------------------------"
  7 echo "__ Current Directory: $(pwd)"
  8 echo "__ Uptime: $(uptime -p)"
  9 echo "_  OS Version: $(lsb_release -d | cut -f2-)"
 10 echo "__ Kernel Version: $(uname -r)"
 11 echo "__ Disk Usage:"
 12 df -h | head -5
 13 echo "__ Memory Usage:"
 14 free -h
 15 echo "__ Top Processes:"
 16 top -b -n 1 | head -10
 17 echo "__ Last 10 Commands:"
 18 history | tail -10 #to see the output of this command use bash -i <filename>
 19  
 20 # use sh <filename> to execute this file