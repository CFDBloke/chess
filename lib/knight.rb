# frozen_string_literal: true

require_relative '../lib/piece'
require_relative '../lib/string'

# The knight playing piece
class Knight < Piece
  attr_accessor :id, :piece_hash

  def initialize(player_num, color, piece_num, start_pos)
    super(player_num, color, piece_num, start_pos)
    @id = "N#{piece_num}"
    @piece_hash = { 1 => "       #{@id}",
                    2 => '   /\_   ',
                    3 => '  /_/ )  ',
                    4 => '   /___) ' }
  end

  private

  def initial_adjacents(column, row)
    [[column + 2, row + 1], [column + 2, row - 1], [column + 1, row + 2], [column + 1, row - 2],
     [column - 2, row + 1], [column - 2, row - 1], [column - 1, row + 2], [column - 1, row - 2]]
  end
end
