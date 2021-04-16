# frozen_string_literal: true

require_relative '../lib/piece'
require_relative '../lib/string'

# The queen playing piece
class Queen < Piece
  attr_accessor :id, :piece_hash

  def initialize(player_num, color, piece_num, start_pos)
    super(player_num, color, piece_num, start_pos)
    @id = 'Q'
    @piece_hash = { 1 => "  _/O\\_ #{@id}",
                    2 => '  \   /  ',
                    3 => '   \ /   ',
                    4 => '  /___\  ' }
  end

  def initial_adjacents(column, row)
    [[column + 1, row + 1], [column + 1, row - 1], [column - 1, row + 1], [column - 1, row - 1],
     [column, row + 1], [column, row - 1], [column + 1, row], [column - 1, row]]
  end

  def move_to(target_column, target_row, vertices)
    return :invalid unless target_on_axis?(target_column, target_row)

    return :friendly if friendly_target?(target_column, target_row, vertices)

    return :obstructed if obstructed?(target_column, target_row, vertices)

    :allow_move
  end

  # private

  def target_on_axis?(target_column, target_row)
    target_on_vertical_axis?(target_column) || target_on_horizontal_axis?(target_row) ||
      target_on_diagonal_axis?(target_column, target_row)
  end
end
