#! /bin/bash 
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
QUERIES=(
"ALTER|TABLE|properties|RENAME|COLUMN|weight|TO|atomic_mass"
"ALTER|TABLE|properties|RENAME|COLUMN|melting_point|TO|melting_point_celsius"
"ALTER|TABLE|properties|RENAME|COLUMN|boiling_point|TO|boiling_point_celsius"
"ALTER|TABLE|properties|ALTER|COLUMN|melting_point_celsius|SET|NOT|NULL"
"ALTER|TABLE|properties|ALTER|COLUMN|boiling_point_celsius|SET|NOT|NULL"
"ALTER|TABLE|elements|ADD|CONSTRAINT|elements_name_key|UNIQUE(name)"
"ALTER|TABLE|elements|ADD|CONSTRAINT|elements_symbol_key|UNIQUE(symbol)"
"ALTER|TABLE|elements|ALTER|COLUMN|name|SET|NOT|NULL"
"ALTER|TABLE|elements|ALTER|COLUMN|symbol|SET|NOT|NULL"
"ALTER|TABLE|properties|ADD|FOREIGN|KEY(atomic_number)|REFERENCES|elements(atomic_number)"
"CREATE|TABLE|types|(type_id|SERIAL|PRIMARY|KEY,type|VARCHAR(30)|NOT|NULL)"
"INSERT|INTO|types|VALUES|(1,|'metal'),(2,|'nonmetal'),(3,|'metalloid')"
"ALTER|TABLE|properties|ADD|COLUMN|type_id|INT"
"UPDATE|properties|SET|type_id=(SELECT|types.type_id|FROM|types|WHERE|types.type|=|properties.type)"
"ALTER|TABLE|properties|DROP|COLUMN|type"
"ALTER|TABLE|properties|ALTER|COLUMN|type_id|SET|NOT|NULL"
"ALTER|TABLE|properties|ADD|CONSTRAINT|properties_type_id_fkey|FOREIGN|KEY(type_id)|REFERENCES|types(type_id)"
"UPDATE|elements|SET|symbol=CONCAT(UPPER(LEFT(symbol,1)),RIGHT(symbol,LENGTH(symbol)-1))"
"ALTER|TABLE|properties|ALTER|COLUMN|atomic_mass|TYPE|REAL"
"INSERT|INTO|elements|VALUES(9,'F','Fluorine'),(10,'Ne','Neon')"
"INSERT|INTO|properties(atomic_number,atomic_mass,melting_point_celsius,boiling_point_celsius,type_id)|VALUES(9,18.998,-220,-188.1,2),(10,20.18,-248.6,-246.1,2)"
"DELETE|FROM|properties|WHERE|atomic_number=1000"
"DELETE|FROM|elements|WHERE|atomic_number=1000"
)

for i in ${QUERIES[@]};
do
$PSQL "$(echo ${i} | sed -E 's/\|/ /g')"
done
