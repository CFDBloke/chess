# frozen_string_literal: true

require_relative '../lib/piece'
require_relative '../lib/string'

# The bishop playing piece
class Rook < Piece
  attr_accessor :id, :piece_hash

  def initialize(player_num, color, piece_num, start_pos)
    super(player_num, color, piece_num, start_pos)
    @id = "R#{piece_num}"
    @piece_hash = { 1 => "           #{@id}",
                    2 => '   n_n_n_n   ',
                    3 => '   \     /   ',
                    4 => '    |   |    ',
                    5 => '   /_____\   ' }
  end

  def initial_adjacents(column, row)
    [[column, row + 1], [column, row - 1], [column + 1, row], [column - 1, row]]
  end
end
