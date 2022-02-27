
#!/bin/bash

BOLD=`tput bold`
NORM=`tput sgr0`

db_port=5432
db_user="postgres"
db_host="127.0.0.1"

function HELP {
  echo "${BOLD}NAME${NORM}"
  echo -e "  make pg_dump to selected directory with current date in filename"\\n
  echo "${BOLD}DESCRIPTION"
  echo "  ${BOLD}-D${NORM}      dest directory for backup"
  echo "  ${BOLD}-d${NORM}      database name"
  echo "  ${BOLD}-U${NORM}      database user. Default is postgres"
  echo "  ${BOLD}-p${NORM}      database port. Default is 5432"
  echo "  ${BOLD}-H${NORM}      database host. Default is 127.0.0.1"
  echo "  ${BOLD}-h${NORM}      show this help message and exit"
  exit 1
}

while getopts D:d:U:p:H:h flag
  do
    case "${flag}" in
      D) dest_dir=${OPTARG};;
      d) db_name=${OPTARG};;
      U) db_user=${OPTARG};;
      p) db_port=${OPTARGS};;
      H) db_host=${OPTARG};;
      h) HELP;;
    esac
  done

curr_date=$(date +'%Y-%m-%d')
backup_dir="${dest_dir}/${db_name}/backup-${curr_date}"

mkdir -p ${backup_dir}
pg_dump -h ${db_host} -p ${db_port} -d ${db_name} > "${backup_dir}/${db_name}.sql"
