# frozen_string_literal: true

# A generic playing piece. All other piece types inherit from this piece
class Piece
  attr_accessor :adjacents

  def initialize(player_num, color, piece_num, start_pos)
    @player_num = player_num
    @color = color
    @current_pos = start_pos
    @piece_num = piece_num
    @adjacents = find_adjacents(@current_pos[0], @current_pos[1])
  end

  def color_code
    @color == :white ? 39 : 30
  end

  private

  def find_adjacents(column, row)
    adjacents = initial_adjacents(column, row)
    adjacents.select { |position| position[0].between?(1, 8) && position[1].between?(1, 8) }
  end
end
