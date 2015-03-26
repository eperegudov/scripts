## Oracle RDBMS specified environment variables for Bourne Shell

export ORACLE_HOSTNAME=dbhost.example.org
export ORACLE_TERM=xterm
export ORACLE_SID=dbname

ORAENV_ASK=NO
. oraenv -s
unset ORAENV_ASK

export ORACLE_HOME

export ORACLE_PATH=.:${ORACLE_HOME}/rdbms/admin

export NLS_LANG=RUSSIAN_CIS.AL32UTF8
export NLS_DATE_FORMAT="DD-MON-YYYY HH24:MI:SS"

export PATH=${PATH}:${HOME}/scripts

