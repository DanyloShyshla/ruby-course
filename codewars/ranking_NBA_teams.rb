RESULT_SHEET = "Los Angeles Clippers 104 Dallas Mavericks 88,New York Knicks 101.123 Atlanta Hawks 112,Indiana Pacers 103 Memphis Grizzlies 112,"\
     "Los Angeles Lakers 111 Minnesota Timberwolves 112,Phoenix Suns 95 Dallas Mavericks 111,Portland Trail Blazers 112 New Orleans Pelicans 94,"\
     "Sacramento Kings 104 Los Angeles Clippers 111,Houston Rockets 85 Denver Nuggets 105,Memphis Grizzlies 76 Cleveland Cavaliers 106,"\
     "Milwaukee Bucks 97 New York Knicks 122,Oklahoma City Thunder 112 San Antonio Spurs 106,Boston Celtics 112 Philadelphia 76ers 95,"\
     "Brooklyn Nets 100 Chicago Bulls 115,Detroit Pistons 92 Utah Jazz 87,Miami Heat 104 Charlotte Hornets 94,"\
     "Toronto Raptors 106 Indiana Pacers 99,Orlando Magic 87 Washington Wizards 88,Golden State Warriors 111 New Orleans Pelicans 95,"\
     "Atlanta Hawks 94 Detroit Pistons 106,Chicago Bulls 97 Cleveland Cavaliers 95,"\
     "San Antonio Spurs 111 Houston Rockets 86,Chicago Bulls 103 Dallas Mavericks 102,Minnesota Timberwolves 112 Milwaukee Bucks 108,"\
     "New Orleans Pelicans 93 Miami Heat 90,Boston Celtics 81 Philadelphia 76ers 65,Detroit Pistons 115 Atlanta Hawks 87,"\
     "Toronto Raptors 92 Washington Wizards 82,Orlando Magic 86 Memphis Grizzlies 76,Los Angeles Clippers 115 Portland Trail Blazers 109,"\
     "Los Angeles Lakers 97 Golden State Warriors 136,Utah Jazz 98 Denver Nuggets 78,Boston Celtics 99 New York Knicks 85,"\
     "Indiana Pacers 98 Charlotte Hornets 86,Dallas Mavericks 87 Phoenix Suns 99,Atlanta Hawks 81 Memphis Grizzlies 82,"\
     "Miami Heat 110 Washington Wizards 105,Detroit Pistons 94 Charlotte Hornets 99,Orlando Magic 110 New Orleans Pelicans 107,"\
     "Los Angeles Clippers 130 Golden State Warriors 95,Utah Jazz 102 Oklahoma City Thunder 113,San Antonio Spurs 84 Phoenix Suns 104,"\
     "Chicago Bulls 103 Indiana Pacers 94,Milwaukee Bucks 106 Minnesota Timberwolves 88,Los Angeles Lakers 104 Portland Trail Blazers 102,"\
     "Houston Rockets 120 New Orleans Pelicans 100,Boston Celtics 111 Brooklyn Nets 105,Charlotte Hornets 94 Chicago Bulls 86,"\
     "Cleveland Cavaliers 103 Dallas Mavericks 97".freeze

TEAMS = "Los Angeles Clippers,Dallas Mavericks,New York Knicks,NYK,Atlanta Hawks,Indiana Pacers,Memphis Grizzlies,"\
         "Los Angeles Lakers,Minnesota Timberwolves,Phoenix Suns,Portland Trail Blazers,New Orleans Pelicans,"\
         "Sacramento Kings,Los Angeles Clippers,Houston Rockets,Denver Nuggets,Cleveland Cavaliers,Milwaukee Bucks,"\
         "Oklahoma City Thunder, San Antonio Spurs,Boston Celtics,Philadelphia 76ers,Brooklyn Nets,Chicago Bulls,"\
         "Detroit Pistons,Utah Jazz,Miami Heat,Charlotte Hornets,Toronto Raptors,Orlando Magic,Washington Wizards,"\
         "Golden State Warriors,Dallas Maver"

def nba_cup(result_sheet, to_find)
  results = { wins: 0, draws: 0, losses: 0, scored: 0, conceded: 0, points: 0 }

  parser = lambda do |to_find, game|
    game_score = game.scan(/\d+\w/)

    if game_score.size > 2
      puts 'One of team names contains numbers'
      game_score.each do |res|
        game_score.delete(res) if res[/[a-z]/]
      end
    end

    if game.start_with?(to_find)
      scored_in_game = game_score[0].to_i
      conceded_in_game = game_score[1].to_i
    else
      conceded_in_game = game_score[0].to_i
      scored_in_game = game_score[1].to_i
    end

    return scored_in_game, conceded_in_game
  end

  calc_game_results = lambda do |scored, conceded, wins, losses, draws, points|
    if scored > conceded
      wins += 1
      points += 3
    elsif scored < conceded
      losses += 1
    else
      draws += 1
      points += 1
    end
    return wins, losses, draws, points
  end

  process_game = lambda do |game|
    if game.include?(to_find)

      scored, conceded = parser.call(to_find, game)

      total_scored = results[:scored] + scored
      total_conceded = results[:conceded] + conceded
      results.update(scored: total_scored, conceded: total_conceded)

      wins, losses, draws, points = calc_game_results.call(scored, conceded, results[:wins], results[:losses], results[:draws], results[:points])
      results.update(wins: wins, losses: losses, draws: draws, points: points)
    end
  end

  check_if_float = lambda do |game|
    game[/[0-9]\.[0-9]/] ? "Error(float number): #{game}" : process_game.call(game)
  end

  if to_find == ''
    ''
  elsif result_sheet.include?(to_find + ' ')
    games = result_sheet.split(',')
    games.each do |game|
      check_if_float.call(game)
    end
    "#{to_find}:W=#{results[:wins]};D=#{results[:draws]};L=#{results[:losses]};Scored=#{results[:scored]};Conceded=#{results[:conceded]};Points=#{results[:points]}"
  else
    "#{to_find}:This team didn't play!"
  end

end

puts nba_cup(RESULT_SHEET, 'Atlanta Hawks')
