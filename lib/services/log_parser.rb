# frozen_string_literal: true

require_relative '../match'
require_relative '../player'

class LogParser
  VALID_EXTENSION = '.log'
  INVALID_EXTENSION = 'Invalid file extension'
  INVALID_INPUT = 'Invalid input'
  INIT_GAME = /InitGame/
  KILL = /Kill:/

  def self.call(file_path)
    new(file_path).call
  end

  def initialize(file_path)
    @file_path = file_path
    @matches = []
  end

  def call
    validate_file

    current_match = nil

    File.foreach(@file_path) do |line|
      case line
      when INIT_GAME
        current_match = start_new_match(current_match)
      when KILL
        process_kill_line(current_match, line)
      end
    end

    finalize_match(current_match)

    @matches
  end

  def validate_file
    raise INVALID_EXTENSION unless File.extname(@file_path) == VALID_EXTENSION
    raise INVALID_INPUT if File.empty?(@file_path)
  end

  def start_new_match(current_match)
    current_match&.finish
    match = Match.new
    @matches << match
    match
  end

  def process_kill_line(current_match, line)
    killer, victim, kill_means = extract_kill_data(line)
    current_match&.add_kill(killer, victim, kill_means)
  end

  def extract_kill_data(line)
    line.match(/Kill: \d+ \d+ \d+: (\w+|<\w+>) killed (\w+) by (\w+)/)&.captures
  end

  def finalize_match(current_match)
    current_match.finish
  end
end
