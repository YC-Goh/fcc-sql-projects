#!/bin/bash
USER=freecodecamp
DB=number_guess
PSQL="psql -U $USER -d $DB -t --no-align -c"
SECRET_NUMBER=$(($RANDOM % 1000 + 1))
TRIM() {
  echo $*|sed -E 's/^\s+|\s+$//g'
}
echo -e "\nRandom Number Guessing Game\n"
echo "Enter your username:"
IFS= read USERNAME
while [[ ! $USERNAME =~ ^[0-9a-zA-Z\_]{1,22}$ ]]
do
  if [[ -z $USERNAME ]]
  then
    echo "Nothing entered. Enter your username:"
  else
    echo "A username should not have spaces and be at most 22 characters long:"
  fi
  IFS= read USERNAME
done
USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
if [[ -z $USER_ID ]]
then
  echo -e "Welcome, $USERNAME! It looks like this is your first time here."
else
  IFS="|" read USERNAME GAMES_PLAYED BEST_GAME < <(echo $($PSQL "SELECT username, games_played, best_game FROM users WHERE user_id=$USER_ID"))
  echo -e "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi
NUMBER_OF_GUESSES=0
NUMBER_GUESSED=0
echo "Guess the secret number between 1 and 1000:"
while [[ $NUMBER_GUESSED -eq 0 ]]
do
  IFS= read USER_GUESS
  if [[ $USER_GUESS =~ ^[0-9]+$ ]]
  then
    (( NUMBER_OF_GUESSES++ ))
    if [[ $USER_GUESS -eq $SECRET_NUMBER ]]
    then
      echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
      NUMBER_GUESSED=1
    else
      if [[ $USER_GUESS -lt $SECRET_NUMBER ]]
      then
        echo "It's higher than that, guess again:"
      else
        echo "It's lower than that, guess again:"
      fi
    fi
  else
    echo "That is not an integer, guess again:"
  fi
done
if [[ -z $USER_ID ]]
then
  INSERT_NEW_USER_RESULT=$($PSQL "INSERT INTO users (username, games_played, best_game) VALUES ('$USERNAME', 1, $NUMBER_OF_GUESSES)")
else
  (( GAMES_PLAYED++ ))
  UPDATE_GAMES_PLAYED_RESULT=$($PSQL "UPDATE users SET games_played=$GAMES_PLAYED WHERE user_id=$USER_ID")
  if [[ $NUMBER_OF_GUESSES -lt $BEST_GAME ]]
  then
    UPDATE_BEST_GAME_RESULT=$($PSQL "UPDATE users SET best_game=$NUMBER_OF_GUESSES WHERE user_id=$USER_ID")
  fi
fi