#/bin/bash

# absolute path of input directory
DIR=$1
OUTFILE=$2

for i in $(find $DIR -maxdepth 1 -type d);
do
	UNIX=$(getfattr -d -n ceph.dir.rctime $i | grep "ceph.dir.rctime" | cut -d\" -f2) 2>/dev/null
	TIME=$(getfattr -d -n ceph.dir.rctime $i | grep "ceph.dir.rctime" | cut -d\" -f2  | { read gmt ; date -d @$gmt ; }) 2>/dev/null
	VOL=$(getfattr -d -n ceph.dir.rbytes $i | grep "ceph.dir.rbytes"| cut -d "=" -f 2 | tr -d '\n' | tr -d '"') 2>/dev/null
	USR=$(echo $i | cut -d "/" -f 4)
	#echo $($VOL + 1)
	if [ $VOL != 0 ]; then		
		echo "$USR $VOL $TIME $UNIX"  >> $OUTFILE 
	fi
done;

# output columns in format:
# username | volume (bytes) | pretty data info | unix timestamp

tail -n +2 "$OUTFILE" > "$OUTFILE.tmp" && mv "$OUTFILE.tmp" "$OUTFILE"
sort -k 9n $OUTFILE > "$OUTFILE.tmp" && mv "$OUTFILE.tmp" "$OUTFILE"

echo "last disk usage stats for folder $DIR created at $OUTFILE"
