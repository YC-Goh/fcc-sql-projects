#!/bin/bash
USER=freecodecamp
DB=number_guess
PSQL="psql -U $USER -d $DB -t --no-align -c"
echo -e "\nRandom Number Guessing Game\n"
SECRET_NUMBER=$(($RANDOM % 1000 + 1))
STATE=1
while [[ $STATE != 9 ]]
do
  case $STATE in
  1)
    echo -e "Enter your username:"
    IFS= read USERNAME
    if [[ $USERNAME =~ ^[0-9a-zA-Z_]{1,22}$ ]]
    then
      STATE=2
    else
      echo -e "A username should not have spaces and be at most 22 characters long:"
    fi
  ;;
  2)
    USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
    if [[ -z $USER_ID ]]
    then
      echo -e "Welcome, $USERNAME! It looks like this is your first time here."
    else
      IFS="|" read USERNAME GAMES_PLAYED BEST_GAME < <(echo $($PSQL "SELECT username, games_played, best_game FROM users WHERE user_id=$USER_ID"))
      echo -e "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
    fi
    NUMBER_OF_GUESSES=0
    STATE=3
  ;;
  3)
    echo -e "Guess the secret number between 1 and 1000:"
    IFS= read USER_GUESS
    STATE=4
  ;;
  4)
    if [[ $USER_GUESS =~ ^[0-9]+$ ]]
    then
      (( NUMBER_OF_GUESSES++ ))
      if [[ $USER_GUESS -eq $SECRET_NUMBER ]]
      then
        echo -e "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
        STATE=5
      else
        if [[ $USER_GUESS -lt $SECRET_NUMBER ]]
        then
          echo -e "It's higher than that, guess again:"
        else
          echo -e "It's lower than that, guess again:"
        fi
      fi
    else
      echo -e "That is not an integer, guess again:"
    fi
    if [[ $STATE -eq 4 ]]
    then
      IFS= read USER_GUESS
    fi
  ;;
  5)
    if [[ -z $USER_ID ]]
    then
      INSERT_NEW_USER_RESULT=$($PSQL "INSERT INTO users (username, games_played, best_game) VALUES ('$USERNAME', 1, $NUMBER_OF_GUESSES)")
    else
      (( GAMES_PLAYED++ ))
      UPDATE_GAMES_PLAYED_RESULT=$($PSQL "UPDATE users SET games_played=$GAMES_PLAYED WHERE user_id='$USER_ID'")
      if [[ $NUMBER_OF_GUESSES -lt $BEST_GAME ]]
      then
        UPDATE_BEST_GAME_RESULT=$($PSQL "UPDATE users SET best_game=$NUMBER_OF_GUESSES WHERE user_id='$USER_ID'")
      fi
    fi
    STATE=9
  ;;
  *)
    STATE=9
  ;;
  esac
done