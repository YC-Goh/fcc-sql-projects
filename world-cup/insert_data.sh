#! /bin/bash
: '
if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi
'
PSQL="psql --username=gohyc --dbname=worldcup -t --no-align -c"
# Do not change code above this line. Use the PSQL variable above to query your database.

echo "$($PSQL "DROP TABLE teams, games;")"
echo "$($PSQL "CREATE TABLE teams (team_id SERIAL PRIMARY KEY, name VARCHAR(32) UNIQUE NOT NULL);")"
echo "$($PSQL "CREATE TABLE games (game_id SERIAL PRIMARY KEY, year INT NOT NULL, round VARCHAR(32) NOT NULL, winner_id INT NOT NULL REFERENCES teams (team_id), opponent_id INT NOT NULL REFERENCES teams (team_id), winner_goals INT NOT NULL, opponent_goals INT NOT NULL);")"

cat "games.csv" | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $WINNER != "winner" ]]
  then
    # Insert winner and opponent into teams TABLE
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    if [[ -z $WINNER_ID ]]
    then
      INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams (name) VALUES ('$WINNER');")
      if [[ $INSERT_WINNER_RESULT = "INSERT 0 1" ]]
      then
        WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
      fi
    fi
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
    if [[ -z $OPPONENT_ID ]]
    then
      INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams (name) VALUES ('$OPPONENT');")
      if [[ $INSERT_WINNER_RESULT = "INSERT 0 1" ]]
      then
        OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
      fi
    fi
    # Insert rest of details into games TABLE
    INSERT_GAME_RESULT=$($PSQL "INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS);")
    if [[ $INSERT_GAME_RESULT != "INSERT 0 1" ]]
    then
      echo "Problem inserting game ($YEAR, $ROUND, $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)"
    fi
  fi
done
