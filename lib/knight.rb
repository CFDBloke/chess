# frozen_string_literal: true

require_relative '../lib/piece'
require_relative '../lib/string'

# The knight playing piece
class Knight < Piece
  def initialize(player_num, color, piece_num, start_pos)
    super(player_num, color, piece_num, start_pos)
    @id = "N#{piece_num}"
  end

  def draw(row)
    piece_hash = { 1 => "  __/\\ #{@id}".colorize(@color).colorize(1),
                   2 => ' /__  \  '.colorize(@color).colorize(1),
                   3 => '   /  |  '.colorize(@color).colorize(1),
                   4 => '  /____\ '.colorize(@color).colorize(1) }
    puts piece_hash[row]
  end
end

knight = Knight.new(1, 41, 1, [1, 1])

4.times { |num| knight.draw(num + 1) }
