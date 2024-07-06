# frozen_string_literal: true

require 'rspec'
require_relative '../lib/match'
require_relative '../lib/player'

describe Match do
  let(:match) { described_class.new }

  describe '#add_kill' do
    context 'when killer and victim are different' do
      it 'increases total kills' do
        expect { match.add_kill('killer', 'victim', 'gun') }.to change(match, :total_kills).by(1)
      end

      it 'increases kills by means' do
        expect { match.add_kill('killer', 'victim', 'gun') }.to change { match.kills_by_means['gun'] }.by(1)
      end

      it 'decreases victim kills if killed by world' do
        match.add_player('victim')
        expect {
          match.add_kill('<world>', 'victim', 'fell_from_high_place')
        }.to change { match.players['victim'].kills }.by(-1)
      end

      it 'increases killer kills if not killed by world' do
        match.add_player('killer')
        expect { match.add_kill('killer', 'victim', 'gun') }.to change { match.players['killer'].kills }.by(1)
      end
    end

    context 'when killer and victim are the same' do
      it 'does not increase total kills' do
        expect { match.add_kill('player', 'player', 'gun') }.not_to change(match, :total_kills)
      end
    end
  end

  describe '#finish' do
    it 'resets kills of players with negative kills' do
      match.add_player('player1')
      match.players['player1'].kills = -1
      match.finish
      expect(match.players['player1'].kills).to eq(0)
    end
  end
end
