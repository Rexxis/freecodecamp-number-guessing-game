#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

STEPS=0
SECRET_NUMBER=$(echo $(( $RANDOM % 1000 + 1 )))

# prompt user enter username

# query get username data (#username, games_played, best_game>
# if username not exist
  # welcome new user msg
  # function main game
# if username exist
  # welcome existing user message 
  # function main game

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