#!/bin/bash

# The following code will take an input attribute and return the desired information related to that input

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
  echo -e 'Please provide an element as an argument.'
  else
  # Check if the input is a number
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1;")
  else
    ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name ILIKE '$1' OR symbol ILIKE '$1';")
  fi

  # not found
  if [[ -z $ELEMENT ]]
  then
    echo -e "I could not find that element in the database."
    else
      echo "$ELEMENT" | while read TYPE_ID BAR ATOMIC_N BAR SYMBOL BAR NAME BAR ATOMIC_M BAR MELTING BAR BOILING BAR TYPE
      do
        echo "The element with atomic number $ATOMIC_N is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_M amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
  fi
fi

# END OF FILE
