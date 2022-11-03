#!/bin/bash
export $(grep -v '^#' .env | xargs)
nohup java -jar bookkeeping-user-0.1.jar> 1.log 2>&1 &
echo $! > pid.file