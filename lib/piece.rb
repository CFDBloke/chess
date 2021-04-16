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

    squares.square(target_column, target_row).piece.player_num == @player_num
  end

  def movement_direction(target_column, target_row)
    if target_on_vertical_axis?(target_column)
      target_row < @current_pos[1] ? :North : :South
    elsif target_on_horizontal_axis?(target_row)
      target_column < @current_pos[0] ? :West : :East
    else
      diagonal_direction(target_column, target_row)
    end
  end

  def find_path(target_column, target_row, direction)
    direction_def = { North: [0, -1], South: [0, 1], East: [1, 0], West: [-1, 0],
                      NorthEast: [1, -1], SouthEast: [1, 1], NorthWest: [-1, -1], SouthWest: [-1, 1] }
    path_direction = direction_def[direction]
    path = []
    extract_path(target_column, target_row, path_direction, @current_pos, path)
  end

  # private

  def extract_path(target_column, target_row, path_direction, current_pos, path)
    next_pos_column = current_pos[0] + path_direction[0]
    next_pos_row = current_pos[1] + path_direction[1]

    return path if next_pos_column == target_column && next_pos_row == target_row

    current_pos = [next_pos_column, next_pos_row]
    path.push(current_pos)

    extract_path(target_column, target_row, path_direction, current_pos, path)
  end

  def diagonal_direction(target_column, target_row)
    if target_column > @current_pos[0] && target_row < @current_pos[1]
      :NorthEast
    elsif target_column > @current_pos[0] && target_row > @current_pos[1]
      :SouthEast
    elsif target_column < @current_pos[0] && target_row < @current_pos[1]
      :NorthWest
    else
      :SouthWest
    end
  end

  def find_adjacents(column, row)
    adjacents = initial_adjacents(column, row)
    adjacents.select { |position| position[0].between?(1, 8) && position[1].between?(1, 8) }
  end
end
