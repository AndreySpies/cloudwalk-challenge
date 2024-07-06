# frozen_string_literal: true

require_relative '../lib/services/log_parser'
require_relative '../lib/match'
require_relative '../lib/player'

RSpec.describe 'Log Parsing' do
  context 'with a valid log file' do
    let(:log_file_path) { File.join(__dir__, 'fixtures', 'matches.log') }
    let(:matches) { LogParser.new(log_file_path).call }

    it 'load matches' do
      expect(matches.size).to eq(4)
    end

    it 'reads the data for the first match' do
      expect(matches[0].players).to eq({})
      expect(matches[0].total_kills).to eq(0)
      expect(matches[0].kills_by_means).to eq({})
    end

    it 'reads the data for the second match' do
      expect(matches[1].players.first[0]).to eq('Isgalamido')
      expect(matches[1].players.first[1].kills).to eq(0)

      expect(matches[1].total_kills).to eq(9)

      expected_kills_by_means = {
        'MOD_TRIGGER_HURT' => 7,
        'MOD_ROCKET_SPLASH' => 1,
        'MOD_FALLING' => 1
      }
      expect(matches[1].kills_by_means).to eq(expected_kills_by_means)
    end

    it 'reads the data for the third match' do
      expect(matches[2].players['semMira'].name).to eq('semMira')
      expect(matches[2].players['semMira'].kills).to eq(4)

      expect(matches[2].players['Isgalamido'].name).to eq('Isgalamido')
      expect(matches[2].players['Isgalamido'].kills).to eq(0)

      expect(matches[2].players['Mocinha'].name).to eq('Mocinha')
      expect(matches[2].players['Mocinha'].kills).to eq(2)

      expected_kills_by_means = {
        'MOD_WEAPON' => 2,
        'MOD_TRIGGER_HURT' => 5,
        'MOD_ROCKET_SPLASH' => 6,
        'MOD_FALLING' => 1
      }
      expect(matches[2].kills_by_means).to eq(expected_kills_by_means)
    end
  end

  context 'with a invalid log file' do
    let(:invalid_extension_log_file_path) { File.join(__dir__, 'fixtures', 'file_with_invalid_extension.txt') }
    let(:empty_log_file_path) { File.join(__dir__, 'fixtures', 'file_empty.log') }

    context 'with a file that has an invalid extension' do
      it 'raises an invalid extension error' do
        expect { LogParser.call(invalid_extension_log_file_path) }.to raise_error(LogParser::INVALID_EXTENSION)
      end
    end

    context 'with an empty .log file' do
      it 'raises an invalid input error' do
        expect { LogParser.call(empty_log_file_path) }.to raise_error(LogParser::INVALID_INPUT)
      end
    end
  end
end
