#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --tuples-only -c"
SQL="SELECT atomic_number,name,symbol,type,atomic_mass,melting_point_celsius,boiling_point_celsius FROM properties JOIN elements USING(atomic_number) JOIN types USING(type_id) WHERE"
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit
elif [[ $1 =~ ^[1-9]+$ ]]
then
  COND="atomic_number=$1" 
else
  COND="name ='$1' OR symbol='$1'"
fi
ELEMENT=$($PSQL "$SQL $COND")
if [[ -z $ELEMENT ]]
then
  echo "I could not find that element in the database."
  exit
else 
  echo "$ELEMENT" | while read ATOMIC_NUMBER VAR NAME VAR SYMBOL VAR TYPE VAR ATOMIC_MASS VAR MELTING_POINT_CELSIUS VAR BOILING_POINT_CELSIUS
  do
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
    #echo $SYMBOL
  done
  exit
fi