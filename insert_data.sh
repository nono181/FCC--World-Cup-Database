#!/bin/bash

# Set database connection
if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Insert unique teams into teams table
cat games.csv | tail -n +2 | cut -d',' -f3,4 | tr ',' '\n' | sort -u | while read TEAM
do
  if [[ -n "$TEAM" ]]
  then
    $PSQL "INSERT INTO teams(name) VALUES('$TEAM') ON CONFLICT (name) DO NOTHING;"
  fi
done

# Insert games into games table
tail -n +2 games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
  OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")

  if [[ -n "$WINNER_ID" && -n "$OPPONENT_ID" ]]
  then
    $PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS);"
  fi
done
