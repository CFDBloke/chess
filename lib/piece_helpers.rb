# frozen_string_literal: true

# Helper methods for the Piece class
module PieceHelpers
  def on_board?(target_column, target_row)
    target_column.between?(1, 8) && target_row.between?(1, 8)
  end

  def target_on_vertical_axis?(target_column)
    @current_pos[0] == target_column
  end

  def target_on_horizontal_axis?(target_row)
    @current_pos[1] == target_row
  end

  def target_on_diagonal_axis?(target_column, target_row)
    (@current_pos[0] - target_column).abs == (@current_pos[1] - target_row).abs
  end

  def in_range?(target_column, target_row)
    return true if @move_distance == :unlimited

    (@current_pos[0] - target_column).abs <= @move_distance && (@current_pos[1] - target_row).abs <= @move_distance
  end

  def friendly_target?(target_column, target_row, squares)
    return false if squares.square(target_column, target_row).piece.nil?

    squares.square(target_column, target_row).piece.player_num == @player_num
  end

  def obstructed?(target_column, target_row, squares)
    direction = movement_direction(target_column, target_row)

    path = find_path(target_column, target_row, direction)

    path = path.map { |position| !squares.square(position[0], position[1]).piece.nil? }

    path.any?(true)
  end

  def find_path(target_column, target_row, direction)
    direction_def = { North: [0, -1], South: [0, 1], East: [1, 0], West: [-1, 0],
                      NorthEast: [1, -1], SouthEast: [1, 1], NorthWest: [-1, -1], SouthWest: [-1, 1] }
    path_direction = direction_def[direction]

    path = []
    extract_path(target_column, target_row, path_direction, @current_pos, path)
  end

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
end
