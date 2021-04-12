# frozen_string_literal: true

require_relative '../lib/piece'
require_relative '../lib/string'

# The king playing piece
class King < Piece
  attr_accessor :id, :piece_hash

  def initialize(player_num, color, piece_num, start_pos)
    super(player_num, color, piece_num, start_pos)
    @id = 'K'
    @piece_hash = { 1 => "  _+|+_ #{@id}",
                    2 => '  \   /  ',
                    3 => '   | |   ',
                    4 => '  /___\  ' }
  end

  def initial_adjacents(column, row)
    [[column + 1, row + 1], [column + 1, row - 1], [column - 1, row + 1], [column - 1, row - 1],
     [column, row + 1], [column, row - 1], [column + 1, row], [column - 1, row]]
  end
end
