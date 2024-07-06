# frozen_string_literal: true

require 'rspec'
require_relative '../lib/player'

describe Player do
  let(:player) { described_class.new('Player 1') }

  describe '#increase_kills' do
    it 'increase player kills' do
      expect { player.increase_kills }.to change(player, :kills).by(1)
    end
  end

  describe '#decrease_kills' do
    it 'decrease player kills' do
      expect { player.decrease_kills }.to change(player, :kills).by(-1)
    end
  end
end
