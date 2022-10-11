#!/bin/bash
echo "$TR_TORRENT_NAME is being extracted" >> /config/logs/script.log
cd ${TR_TORRENT_DIR}/${TR_TORRENT_NAME}
unrar e -o- *.rar
echo "extracted to ${TR_TORRENT_DIR}/${TR_TORRENT_NAME}" >> /config/logs/script.log
