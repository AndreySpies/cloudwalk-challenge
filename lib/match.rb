# frozen_string_literal: true

class Match
  WORLD_NAME = '<world>'

  attr_accessor :players, :total_kills, :kills_by_means

  def initialize
    @players = {}
    @total_kills = 0
    @kills_by_means = Hash.new(0)
  end

  def add_kill(killer_name, victim_name, kill_means)
    return if killer_name == victim_name

    increase_total_kills
    increase_kills_by_means(kill_means)

    killed_by_world?(killer_name) ? decrease_player_kills(victim_name) : increase_player_kill(killer_name)
  end

  def increase_total_kills
    self.total_kills += 1
  end

  def increase_kills_by_means(kill_means)
    kills_by_means[kill_means] += 1
  end

  def killed_by_world?(killer_name)
    killer_name == WORLD_NAME
  end

  def decrease_player_kills(victim_name)
    victim = find_or_create_player(victim_name)
    victim.decrease_kills
  end

  def increase_player_kill(killer_name)
    killer = find_or_create_player(killer_name)
    killer.increase_kills
  end

  def find_or_create_player(player_name)
    @players[player_name] ||= Player.new(player_name)
  end

  def add_player(player_name)
    @players[player_name] ||= Player.new(player_name)
  end

  def finish
    @players.each_value { |player| player.kills = 0 if player.kills.negative? }
  end
end
