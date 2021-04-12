# frozen_string_literal: true

# A generic playing piece. All other piece types inherit from this piece
class Piece
  attr_reader :current_pos
  attr_accessor :adjacents

  def initialize(player_num, color, piece_num, start_pos)
    @player_num = player_num
    @color = color
    @adjacents = []
    @current_pos = []
    self.current_pos = start_pos
    @piece_num = piece_num
  end

  def color_code
    @color == :white ? 39 : 30
  end

  def current_pos=(pos)
    @adjacents = find_adjacents(pos[0], pos[1])
    @current_pos = pos
  end

  private

  def find_adjacents(column, row)
    adjacents = initial_adjacents(column, row)
    adjacents.select { |position| position[0].between?(1, 8) && position[1].between?(1, 8) }
  end
end
