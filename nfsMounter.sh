#!/bin/bash

##Choose the delimiter used in fstab
##It is usually a space or a tab
DELIM=' '

NFSMOUNTS=0
POSSIBLE_MATCHES="/tmp/mounPoints.tmp"
NEXTNFSMOUNT=""

##Returns 1 if the all the nfs entries in fstab are mounted, 0 otherwise
function checkMountPoints () {
   grep "nfs"  /etc/fstab > $POSSIBLE_MATCHES
   while read line
   do
      TMP=$(printf  %s "$line" | cut -d "$DELIM" -f 3)
      if [ $TMP == "nfs" ];then
         TMP=$(printf %s "$line" | cut -d "$DELIM" -f 1)
         MATCH=("${MATCH[@]}" $TMP)
      fi
   done <$POSSIBLE_MATCHES
   rm $POSSIBLE_MATCHES
   let "NFSMOUNTS=${#MATCH[@]}"
   eval "ELEMENTS=({1..${#MATCH[@]}})"
   for COUNT in "${ELEMENTS[@]}"
   do
      let "ITERATOR=$COUNT-1"
      PATTERN=$(echo ${MATCH[$ITERATOR]})
      TMP=$(mount | grep $PATTERN)
      if [ "$TMP" == "" ];then
         NEXTNFSMOUNT=$PATTERN
         return 0
      fi
   done
   return 1
}

##Main
checkMountPoints
result=$?
echo "We found $NFSMOUNTS NFS mount points"
if [ $result -eq 0  ];then
    echo "Apparently some mount points were not mounted"
    eval "ELEMENTS=({1..${NFSMOUNTS}})"
    for COUNT in "${ELEMENTS[@]}"
    do
       mount $NEXTNFSMOUNT
       checkMountPoints
       result=$?
       if [ $result -eq 0 ]; then
          echo "Another NFS mount point still needs to be mounted"
       else
          echo "Mount was successful, all nfs devices are mounted"
          break
       fi
    done
else
    echo "Looks like everything is in place"
fi
#!/bin/bash

##Choose the delimiter used in fstab
##It is usually a space or a tab
DELIM=' '

NFSMOUNTS=0
POSSIBLE_MATCHES="/tmp/mounPoints.tmp"
NEXTNFSMOUNT=""

##Returns 1 if the all the nfs entries in fstab are mounted, 0 otherwise
function checkMountPoints () {
   grep "nfs"  /etc/fstab > $POSSIBLE_MATCHES
   while read line
   do
      TMP=$(printf  %s "$line" | cut -d "$DELIM" -f 3)
      if [ $TMP == "nfs" ];then
         TMP=$(printf %s "$line" | cut -d "$DELIM" -f 1)
         MATCH=("${MATCH[@]}" $TMP)
      fi
   done <$POSSIBLE_MATCHES
   rm $POSSIBLE_MATCHES
   let "NFSMOUNTS=${#MATCH[@]}"
   eval "ELEMENTS=({1..${#MATCH[@]}})"
   for COUNT in "${ELEMENTS[@]}"
   do
      let "ITERATOR=$COUNT-1"
      PATTERN=$(echo ${MATCH[$ITERATOR]})
      TMP=$(mount | grep $PATTERN)
      if [ "$TMP" == "" ];then
         NEXTNFSMOUNT=$PATTERN
         return 0
      fi
   done
   return 1
}

##Main
checkMountPoints
result=$?
echo "We found $NFSMOUNTS NFS mount points"
if [ $result -eq 0  ];then
    echo "Apparently some mount points were not mounted"
    eval "ELEMENTS=({1..${NFSMOUNTS}})"
    for COUNT in "${ELEMENTS[@]}"
    do
       mount $NEXTNFSMOUNT
       checkMountPoints
       result=$?
       if [ $result -eq 0 ]; then
          echo "Another NFS mount point still needs to be mounted"
       else
          echo "Mount was successful, all nfs devices are mounted"
          break
       fi
    done
else
    echo "Looks like everything is in place"
fi
