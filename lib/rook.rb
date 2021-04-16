# frozen_string_literal: true

require_relative '../lib/piece'
require_relative '../lib/string'

# The bishop playing piece
class Rook < Piece
  attr_accessor :id, :piece_hash

  def initialize(player_num, color, piece_num, start_pos)
    super(player_num, color, piece_num, start_pos)
    @id = "R#{piece_num}"
    @move_distance = :unlimited
    @piece_hash = { 1 => "       #{@id}",
                    2 => '  n_n_n  ',
                    3 => '  \   /  ',
                    4 => '  /___\  ' }
  end

  private

  def target_on_axis?(target_column, target_row)
    target_on_vertical_axis?(target_column) || target_on_horizontal_axis?(target_row) ||
      target_on_diagonal_axis?(target_column, target_row)
  end
end
