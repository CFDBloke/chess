# frozen_string_literal: true

# A generic playing piece. All other piece types inherit from this piece
class Piece
  attr_reader :player_num
  attr_accessor :adjacents, :current_pos

  def initialize(player_num, color, piece_num, start_pos, can_jump)
    @player_num = player_num
    @color = color
    @can_jump = can_jump
    @current_pos = start_pos
    @piece_num = piece_num
  end

  def color_code
    @color == :white ? 39 : 30
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

  def move_to(target_column, target_row, squares)
    move_checks1 = move_checks1(target_column, target_row, squares)
    return move_checks1 unless move_checks1 == :allow_move

    move_checks2 = move_checks2(target_column, target_row, squares)
    return move_checks2 unless move_checks2 == :allow_move

    @move_distance = 1 if instance_of?(Pawn)

    :allow_move
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

  # private

  def move_checks1(target_column, target_row, squares)
    return :invalid unless on_board?(target_column, target_row)

    return :no_axis unless target_on_axis?(target_column, target_row)

    if instance_of?(Pawn)
      pawn_move = pawn_move(target_column, target_row, squares)
      return pawn_move unless pawn_move == :allow_move
    end

    :allow_move
  end

  def move_checks2(target_column, target_row, squares)
    return :too_far unless in_range?(target_column, target_row)

    return :friendly if friendly_target?(target_column, target_row, squares)

    return :obstructed if !@can_jump && obstructed?(target_column, target_row, squares)

    :allow_move
  end

  def on_board?(target_column, target_row)
    target_column.between?(1, 8) && target_row.between?(1, 8)
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

  def find_adjacents(column, row)
    adjacents = initial_adjacents(column, row)
    adjacents.select { |position| position[0].between?(1, 8) && position[1].between?(1, 8) }
  end
end
