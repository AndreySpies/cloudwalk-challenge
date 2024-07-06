# frozen_string_literal: true

class Reporter
  def self.call(matches, ranking)
    new(matches, ranking).call
  end

  def initialize(matches, ranking)
    @matches = matches
    @ranking = ranking
  end

  def call
    report_matches_details
    report_ranking
  end

  private

  def report_matches_details
    @matches.each_with_index do |match, index|
      puts
      print_match_details(match, index)
      puts '-' * 20
    end
  end

  def report_ranking
    puts
    puts 'Ranking:'
    puts

    @ranking.each_with_index do |(player_name, kills), index|
      puts "#{index + 1}. #{player_name}: #{kills} kills"
    end
  end

  def print_match_details(match, index)
    puts "Match #{index + 1}"
    puts "Total Kills: #{match.total_kills}"
    puts "Players: #{players_names(match)}"
    puts 'Kills:'
    print_match_kills(match)
    puts 'Kills by means:'
    print_kill_by_means(match)
  end

  def players_names(match)
    match.players.map { |key, _value| key }.join(', ')
  end

  def print_match_kills(match)
    match.players.each do |player_name, player|
      puts "  #{player_name}: #{player.kills}"
    end
  end

  def print_kill_by_means(match)
    match.kills_by_means.each do |means, kills|
      puts "  #{means}: #{kills}"
    end
  end
end
