#!/bin/bash

echo "Total number of goals in all games from winning teams:"
psql -U freecodecamp -d worldcup -t --no-align -c "SELECT SUM(winner_goals) FROM games;"

echo "Total number of goals in all games from both teams combined:"
psql -U freecodecamp -d worldcup -t --no-align -c "SELECT SUM(winner_goals + opponent_goals) FROM games;"

echo "Average number of goals in all games from the winning teams:"
psql -U freecodecamp -d worldcup -t --no-align -c "SELECT AVG(winner_goals) FROM games;"

echo "Average number of goals in all games from the winning teams rounded to two decimal places:"
psql -U freecodecamp -d worldcup -t --no-align -c "SELECT ROUND(AVG(winner_goals), 2) FROM games;"

echo "Average number of goals in all games from both teams:"
psql -U freecodecamp -d worldcup -t --no-align -c "SELECT AVG(winner_goals + opponent_goals) FROM games;"

echo "Most goals scored in a single game by one team:"
psql -U freecodecamp -d worldcup -t --no-align -c "SELECT MAX(GREATEST(winner_goals, opponent_goals)) FROM games;"

echo "Number of games where the winning team scored more than two goals:"
psql -U freecodecamp -d worldcup -t --no-align -c "SELECT COUNT(*) FROM games WHERE winner_goals > 2;"

echo "Winner of the 2018 tournament team name:"
psql -U freecodecamp -d worldcup -t --no-align -c "SELECT t.name FROM teams t JOIN games g ON t.team_id = g.winner_id WHERE g.year = 2018 AND g.round = 'Final';"

echo "List of teams who played in the 2014 'Eighth-Final' round:"
psql -U freecodecamp -d worldcup -t --no-align -c "SELECT DISTINCT t.name FROM games g JOIN teams t ON t.team_id = g.winner_id OR t.team_id = g.opponent_id WHERE g.year = 2014 AND g.round = 'Eighth-Final' ORDER BY t.name;"

echo "List of unique winning team names in the whole data set:"
psql -U freecodecamp -d worldcup -t --no-align -c "SELECT DISTINCT t.name FROM games g JOIN teams t ON t.team_id = g.winner_id ORDER BY t.name;"

echo "Year and team name of all the champions:"
psql -U freecodecamp -d worldcup -t --no-align -c "SELECT g.year || '|' || t.name FROM games g JOIN teams t ON t.team_id = g.winner_id WHERE g.round = 'Final' ORDER BY g.year;"

echo "List of teams that start with 'Co':"
psql -U freecodecamp -d worldcup -t --no-align -c "SELECT name FROM teams WHERE name LIKE 'Co%' ORDER BY name;"
