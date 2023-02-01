#!/bin/bash
USER=freecodecamp
DB=number_guess
dropdb -U $USER $DB
createdb -U $USER $DB
PSQL="psql -U $USER -d $DB -t --no-align -c"
echo $($PSQL "CREATE TABLE users (user_id SERIAL PRIMARY KEY, username VARCHAR(32) UNIQUE NOT NULL, games_played INT NOT NULL, best_game INT NOT NULL)")