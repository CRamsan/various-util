#!/bin/bash

#Use bzip2 compression, better compression ratio, takes more cpu
#METHOD=j
#EXTENSION=tbz

#Use gzip compression, the compression ratio is not the best but it is much less cpu intensive
METHOD=z
EXTENSION=tgz

TARGETS=(       "/var/www"
                "/var/wiki"
                "/var/mechtactics"
                "/etc"
                "/opt/floodmonitor.git"
)

OUTPUT="/var/backups"

for i in "${TARGETS[@]}"
do
  STAMP=`date +%d-%m-%y`
  echo `tar -c"$METHOD"f $i-$STAMP.$EXTENSION $i`
  echo `mv $i-$STAMP.$EXTENSION $OUTPUT/`
done

