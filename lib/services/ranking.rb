# frozen_string_literal: true

class Ranking
  def self.call(matches)
    new(matches).call
  end

  def initialize(matches)
    @matches = matches
  end

  def call
    player_scores = aggregate_scores
    sort_players_by_score(player_scores)
  end

  def aggregate_scores
    player_scores = Hash.new(0)

    @matches.each do |match|
      match.players.each do |player_name, player|
        player_scores[player_name] += player.kills
      end
    end

    player_scores
  end

  def sort_players_by_score(player_scores)
    player_scores.sort_by { |_, kills| -kills }
  end
end
