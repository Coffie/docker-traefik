#!/bin/bash
if [ -z "$TR_TORRENT_DIR" ]; then
	TR_TORRENT_DIR="/nodir"
fi
if [ -z "$TR_TORRENT_NAME" ]; then
	TR_TORRENT_NAME="nofile"
fi
DEST_DIR="${TR_TORRENT_DIR}/${TR_TORRENT_NAME}"
LOG_FILE="/var/log/auto_unrar.log"
SRC_DIR="$TR_TORRENT_DIR/$TR_TORRENT_NAME"
# create the extraction directory if it doesn't exist
if [ ! -d "$DEST_DIR" ]; then
	mkdir -p "$DEST_DIR"
fi
function log() {
	echo "`date` - $SRC_DIR - $1" >> "$LOG_FILE"
}
log "Extracing torrent"
# torrent is a single file
if [ -f "$SRC_DIR" ]; then
	TORRENT_EXT="${TR_TORRENT_NAME##*.}"
	if [ "rar" == "$TORRENT_EXT" ]; then
		unrar e -y "$SRC_DIR" "$DEST_DIR" > /dev/null
	else
		log "Error: Torrent is not a RAR file"
	fi
# torrent is a directory
elif [ -d "$SRC_DIR" ]; then
	RAR_FILES=`find "$SRC_DIR" -name "*.rar"`
	if [ ! -z "$RAR_FILES" ]; then
		find "$SRC_DIR" -name "*.rar" -exec unrar e -y {} "$DEST_DIR" \; > /dev/null
	else
		log "Error: Torrent does not have a RAR file"
	fi
# torrent is not a file or directory
else
	log "Error: Torrent is not a file or directory"
fi
if [ ! $? -eq 0 ]; then
	log "Error: Extraction of torrent failed"
fi
log "Finished processing torrent"

