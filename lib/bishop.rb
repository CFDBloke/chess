# frozen_string_literal: true

require_relative '../lib/piece'
require_relative '../lib/string'

# The bishop playing piece
class Bishop < Piece
  attr_accessor :piece_hash

  def initialize(player_num, color, piece_num, start_pos)
    super(player_num, color, piece_num, start_pos)
    @id = "B#{piece_num}"
    @piece_hash = { 1 => "           #{@id}",
                    2 => '      O      ',
                    3 => '     ( )     ',
                    4 => '     \ /     ',
                    5 => '    /___\    ' }
  end

  def initial_adjacents(column, row)
    [[column + 1, row + 1], [column + 1, row - 1], [column - 1, row + 1], [column - 1, row - 1]]
  end
end
