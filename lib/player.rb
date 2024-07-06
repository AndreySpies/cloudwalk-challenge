# frozen_string_literal: true

class Player
  attr_accessor :name, :kills

  def initialize(name)
    @name = name
    @kills = 0
  end

  def increase_kills
    self.kills += 1
  end

  def decrease_kills
    self.kills -= 1
  end
end
