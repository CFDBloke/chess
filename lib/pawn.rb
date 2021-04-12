# frozen_string_literal: true

require_relative '../lib/piece'
require_relative '../lib/string'

# The pawn playing piece
class Pawn < Piece
  attr_accessor :id, :piece_hash

  def initialize(player_num, color, piece_num, start_pos)
    super(player_num, color, piece_num, start_pos)
    @id = "P#{piece_num}"
    @first_move = true
    @move_distance = player_num == 1 ? 2 : -2
    @piece_hash = { 1 => "       #{@id}",
                    2 => '         ',
                    3 => '    O    ',
                    4 => '   /_\   ' }
  end

  def initial_adjacents(column, row)
    if @player_num == 1
      [column, row - 1]
    else
      [column, row + 1]
    end
  end
end
