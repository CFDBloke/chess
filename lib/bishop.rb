# frozen_string_literal: true

require_relative '../lib/piece'
require_relative '../lib/string'

# The bishop playing piece
class Bishop < Piece
  attr_accessor :id, :piece_hash

  def initialize(player_num, color, piece_num, start_pos)
    super(player_num, color, piece_num, start_pos)
    @id = "B#{piece_num}"
    @piece_hash = { 1 => "    O  #{@id}",
                    2 => '   ( )   ',
                    3 => '   \ /   ',
                    4 => '  /___\  ' }
  end

  private

  def target_on_axis?(target_column, target_row)
    target_on_diagonal_axis?(target_column, target_row)
  end
end
