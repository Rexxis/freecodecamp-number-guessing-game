#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

STEPS=0
SECRET_NUMBER=$(echo $(( $RANDOM % 1000 + 1 )))

# start prompt
echo -e "\nEnter your username:"
read USERNAME
# query get username data (#username, games_played, best_game>
USERNAME_DATA=$($PSQL "SELECT username, games_played, best_game FROM userdata WHERE username = '$USERNAME'")
# if username not exist
if [[ -z $USERNAME_DATA ]]
then
  # welcome new user msg
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  # function main game
else
# if username exist
  # welcome existing user message 
  echo "$USERNAME_DATA" | while IFS="|" read USERNAME GAMES_PLAYED BEST_GAME
  do
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  # function main game
  done
fi

# - MAIN GAME FUNCTION -
# echo Guess the secret number.......
# read GUESS
# if not integer
  #if guess lower SECRET NUMBER
    # its higher than that
    # STEPS +1
    # GAME()
  # if guess higher SECRET NUMBER
   # its lower than that
   # STEPS +1
   # GAME()
  # if guess == SECRET_NUMBER
    # echo you guessed it in STEPS tries. The secret number was SECRET_NUMBER. Nice job!
    # GET GAMES PLAYED
    # INSERT GAMES PLAYED +1
    # GET BEST_GAME
    # IF STEPS < BEST_GAME -> UPDATE BEST_GAME with STEPS 
# else
  # echo That is not an integer, guess again: