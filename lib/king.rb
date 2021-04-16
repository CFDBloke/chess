# frozen_string_literal: true

require_relative '../lib/piece'
require_relative '../lib/string'

# The king playing piece
class King < Piece
  attr_accessor :id, :piece_hash

  def initialize(player_num, color, piece_num, start_pos, can_jump)
    super(player_num, color, piece_num, start_pos, can_jump)
    @id = 'K'
    @move_distance = 1
    @piece_hash = { 1 => "  _+|+_ #{@id}",
                    2 => '  \   /  ',
                    3 => '   | |   ',
                    4 => '  /___\  ' }
  end

  # private

  def target_on_axis?(target_column, target_row)
    target_on_vertical_axis?(target_column) || target_on_horizontal_axis?(target_row) ||
      target_on_diagonal_axis?(target_column, target_row)
  end
end
