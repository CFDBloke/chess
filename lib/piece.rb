# frozen_string_literal: true

# A generic playing piece. All other piece types inherit from this piece
class Piece
  attr_reader :player_num, :current_pos
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

  # protected

  def target_on_vertical_axis?(target_column)
    @current_pos[0] == target_column
  end

  def target_on_horizontal_axis?(target_row)
    @current_pos[1] == target_row
  end

  def target_on_diagonal_axis?(target_column, target_row)
    (@current_pos[0] - target_column).abs == (@current_pos[1] - target_row).abs
  end

  def friendly_target?(target_column, target_row, squares)
    return false if squares.square(target_column, target_row).piece.nil?

    vertices.square(target_column, target_row).piece.player_num == @player_num
  end

  # private

  def find_adjacents(column, row)
    adjacents = initial_adjacents(column, row)
    adjacents.select { |position| position[0].between?(1, 8) && position[1].between?(1, 8) }
  end
end
