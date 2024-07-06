# frozen_string_literal: true

require 'rspec'
require_relative '../lib/services/ranking'
require_relative '../lib/match'
require_relative '../lib/player'

RSpec.describe Ranking do
  let(:player1) { Player.new('Player1') }
  let(:player2) { Player.new('Player2') }
  let(:player3) { Player.new('Player3') }

  let(:match1) do
    match = Match.new
    player1 = Player.new('Player1')
    player2 = Player.new('Player2')
    player3 = Player.new('Player3')

    player1.kills = 5
    player2.kills = 3
    player3.kills = 2

    match.players['Player1'] = player1
    match.players['Player2'] = player2
    match.players['Player3'] = player3

    match
  end

  let(:match2) do
    match = Match.new
    player1 = Player.new('Player1')
    player2 = Player.new('Player2')
    player3 = Player.new('Player3')

    player1.kills = 2
    player2.kills = 1
    player3.kills = 4

    match.players['Player1'] = player1
    match.players['Player2'] = player2
    match.players['Player3'] = player3

    match
  end

  let(:matches) { [match1, match2] }

  describe '.call' do
    it 'returns sorted player rankings based on kills' do
      ranking = described_class.call(matches)
      expect(ranking).to eq([['Player1', 7], ['Player3', 6], ['Player2', 4]])
    end
  end

  describe '#aggregate_scores' do
    it 'aggregates the kills for each player' do
      ranking_instance = described_class.new(matches)
      scores = ranking_instance.aggregate_scores
      expect(scores).to eq({ 'Player1' => 7, 'Player2' => 4, 'Player3' => 6 })
    end
  end

  describe '#sort_players_by_score' do
    it 'sorts the players by their kill scores in descending order' do
      ranking_instance = described_class.new(matches)
      scores = { 'Player1' => 7, 'Player2' => 4, 'Player3' => 6 }
      sorted_scores = ranking_instance.sort_players_by_score(scores)
      expect(sorted_scores).to eq([['Player1', 7], ['Player3', 6], ['Player2', 4]])
    end
  end
end
