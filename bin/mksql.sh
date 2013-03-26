set -eu

SRID=102349  # set SRID to stateplane south HARN unless given.
DB=foogis
USER=postgres
VER=9.2

while getopts ":s:d:u:" opt; do
	case $opt in 
		s) 
			SRID=$OPTARG
			;;
		d) 
			DB=$OPTARG
			;;
		u)
			USER=$OPTARG
			;;
		\?)
			echo "mksql: Invalid option: -$OPTARG" >&2
			;;
	esac
done
shift $(( $OPTIND - 1 ))


SHP2PGSQL="/c/Program Files/PostgreSQL/$VER/bin/shp2pgsql.exe"
PSQL="/c/Program Files/PostgreSQL/$VER/bin/psql.exe"

echo "mksql (params): $VER $SRID $DB $USER $SHP2PGSQL $PSQL" >&2

for SHP in "$@"; do

	F=$(echo $SHP | sed 's/\.[^.]*$//')
	echo "mksql: working on $F" >&2
	"$SHP2PGSQL" -s $SRID -I $F > $F.sql;
	"$PSQL" -q -U $USER $DB < $F.sql 
done



# Also UTM10 NAD83 HARN is 3740, non HARN 32610, SP 102349
