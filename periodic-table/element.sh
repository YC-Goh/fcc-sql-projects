#!/bin/bash
PSQL="psql -U freecodecamp -d periodic_table -t -c"
TRIM() {
  echo $1|sed -E 'r/^\s+|\s+$//g'
}
EXIT() {
  echo "I could not find that element in the database."
}
RESULT() {
  echo "The element with atomic number $1 is $3 ($2). It's a $7, with a mass of $4 amu. $3 has a melting point of $5 celsius and a boiling point of $6 celsius."
}
PRINT_DATA() {
  ATOMIC_NUMBER=$1
  ELEMENTS_ROW=$($PSQL "SELECT * FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
  read NUMBER BAR SYMBOL BAR NAME < <(echo "$ELEMENTS_ROW")
  PROPERTIES_ROW=$($PSQL "SELECT * FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
  read NUMBER BAR MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE_ID < <(echo "$PROPERTIES_ROW")
  TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")
  TYPE=$(TRIM $TYPE)
  RESULT $NUMBER $SYMBOL $NAME $MASS $MELTING_POINT $BOILING_POINT $TYPE
}
if [[ $1 ]]
then
  IN=$(TRIM $1)
  if [[ $IN =~ ^[0-9]+$ ]]
  then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$IN")
    ATOMIC_NUMBER=$(TRIM $ATOMIC_NUMBER)
    if [[ -z $ATOMIC_NUMBER ]]
    then
      EXIT
    else
      PRINT_DATA $ATOMIC_NUMBER
    fi
  else
    if [[ $IN =~ ^[A-Z][a-z]?$ ]]
    then
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$IN'")
      ATOMIC_NUMBER=$(TRIM $ATOMIC_NUMBER)
      if [[ -z $ATOMIC_NUMBER ]]
      then
        EXIT
      else
        PRINT_DATA $ATOMIC_NUMBER
      fi
    else
      if [[ $IN =~ ^[A-Z][a-z]+$ ]]
      then
        ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$IN'")
        ATOMIC_NUMBER=$(TRIM $ATOMIC_NUMBER)
        if [[ -z $ATOMIC_NUMBER ]]
        then
          EXIT
        else
          PRINT_DATA $ATOMIC_NUMBER
        fi
      else
        echo "I could not find that element in the database."
      fi
    fi
  fi
else
  echo "Please provide an element as an argument."
fi