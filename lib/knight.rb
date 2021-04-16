# frozen_string_literal: true

require_relative '../lib/piece'
require_relative '../lib/string'

# The knight playing piece
class Knight < Piece
  attr_accessor :id, :piece_hash

  def initialize(player_num, color, piece_num, start_pos, can_jump)
    super(player_num, color, piece_num, start_pos, can_jump)
    @id = "N#{piece_num}"
    @move_distance = :unlimited
    @piece_hash = { 1 => "       #{@id}",
                    2 => '   /\_   ',
                    3 => '  /_/ )  ',
                    4 => '   /___) ' }
  end

  # private

  def target_on_axis?(target_column, target_row)
    column_diff = (@current_pos[0] - target_column).abs
    row_diff = (@current_pos[1] - target_row).abs

    column_diff == 2 && row_diff == 1 || column_diff == 1 && row_diff == 2
  end
end
