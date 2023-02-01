#!/bin/bash
USER=freecodecamp
DB=number_guess
PSQL_OPEN="psql -U $USER -d $DB"
PSQL="$PSQL_OPEN -c"
echo "$($PSQL "\l")"
echo "$($PSQL "\d")"
echo "$($PSQL "\d users")"
echo "$($PSQL "SELECT * FROM users")"
$PSQL_OPEN