#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

STEPS=0
SECRET_NUMBER=$(echo $(( $RANDOM % 1000 + 1 )))
echo $SECRET_NUMBER

MAIN() {
# start prompt
echo -e "\nEnter your username:"
read USERNAME
# query get username data (#username, games_played, best_game>
USERNAME_DATA=$($PSQL "SELECT username, games_played, best_game FROM userdata WHERE username = '$USERNAME'")
# if username not exist
if [[ -z $USERNAME_DATA ]]
then
  # insert new user data
  INSERT_NEW_USER_RESULT=$($PSQL "INSERT INTO userdata(username, games_played, best_game) VALUES ('$USERNAME', 0, NULL)")
  # welcome new user msg
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  echo "Guess the secret number between 1 and 1000:"
  GAME
else
# if username exist
  # welcome existing user message 
  echo "$USERNAME_DATA" | while IFS="|" read USERNAME GAMES_PLAYED BEST_GAME
  do
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  done
  echo "Guess the secret number between 1 and 1000:"
  GAME
fi
}

# - MAIN GAME FUNCTION -
GAME() {
# echo Guess the secret number.......
# read GUESS
  read GUESS
# if integer
  if [[ $GUESS =~ ^[0-9]+$ ]]
  then
    #if guess lower SECRET NUMBER
    if [[ $GUESS -gt $SECRET_NUMBER ]]
    then
    # its higher than that
      echo "It's lower than that, guess again:"
      let "STEPS+=1"
      GAME
    elif [[ $GUESS -lt $SECRET_NUMBER ]]
    then
      echo "It's higher than that, guess again:"
      let "STEPS+=1"
      GAME
    else
      # get games played and best game data
      GAMES_PLAYED=$($PSQL "SELECT games_played FROM userdata WHERE username = '$USERNAME'")
      BEST_GAME=$($PSQL "SELECT best_game FROM userdata WHERE username = '$USERNAME'")
      # increment steps and games played data
      let "STEPS+=1"
      let "GAMES_PLAYED+=1"
      echo "You guessed it in $STEPS tries. The secret number was $SECRET_NUMBER. Nice job!"
      # INSERT GAMES PLAYED +1
      UPDATE_GAMES_PLAYED_RESULT=$($PSQL "UPDATE userdata SET games_played = $GAMES_PLAYED WHERE username = '$USERNAME'")
      # IF STEPS < BEST_GAME -> UPDATE BEST_GAME with STEPS 
      if [[ $STEPS -lt $BEST_GAME ]]
      then
        #insert new best game
        UPDATE_BEST_GAME_RESULT=$($PSQL "UPDATE userdata SET best_game = $STEPS WHERE username = '$USERNAME'")
      else
        UPDATE_BEST_GAME_RESULT=$($PSQL "UPDATE userdata SET best_game = $STEPS WHERE username = '$USERNAME'")
      fi
    fi
  else
    echo "That is not an integer, guess again:"
    GAME
  fi
}
    # STEPS +1
    # GAME()
  # if guess higher SECRET NUMBER
   # its lower than that
   # STEPS +1
   # GAME()
  # if guess == SECRET_NUMBER
    # echo you guessed it in STEPS tries. The secret number was SECRET_NUMBER. Nice job!
# else
  # echo That is not an integer, guess again:

  MAIN