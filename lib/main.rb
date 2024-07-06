# frozen_string_literal: true

require_relative 'services/log_parser'
require_relative 'services/reporter'
require_relative 'services/ranking'

class Main
  def initialize
    file_path = ARGV[0]

    matches = LogParser.call(file_path)
    ranking = Ranking.call(matches)

    Reporter.call(matches, ranking)
  end
end

Main.new
