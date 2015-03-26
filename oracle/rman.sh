#!/bin/bash -l

# Destination to store backup pieces
RMAN_DST=/opt/oracle/backup/rman

# If day of week is Saturday then run full level 0 backup else run incremental level 1 backup
[ "$(LANG=C date +%A)" == "Saturday" ] && RMAN_INC=0 || RMAN_INC=1

RMAN_TASK="

SPOOL LOG TO '${RMAN_DST}/rman-$(date +%Y%m%d).log';

CONFIGURE BACKUP OPTIMIZATION ON;
CONFIGURE CONTROLFILE AUTOBACKUP ON;
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '${RMAN_DST}/controlfile_%F.bck';
CONFIGURE CHANNEL DEVICE TYPE DISK FORMAT '${RMAN_DST}/backup_%d_set%s_piece%p_copy%c_%T_%U.bck';

BACKUP VALIDATE CHECK LOGICAL DATABASE;
BACKUP AS COMPRESSED BACKUPSET INCREMENTAL LEVEL ${RMAN_INC} DATABASE PLUS ARCHIVELOG DELETE INPUT;

DELETE NOPROMPT OBSOLETE;
SPOOL LOG OFF;

EXIT;
"

rman target=/ <<< ${RMAN_TASK}
