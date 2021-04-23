# frozen_string_literal: true

require_relative '../lib/piece_helpers'

# A generic playing piece. All other piece types inherit from this piece
class Piece
  attr_reader :player_num
  attr_accessor :adjacents, :current_pos, :next_moves, :last_pos

  include PieceHelpers

  def initialize(player_num, color, piece_num, start_pos, can_jump)
    @player_num = player_num
    @color = color
    @can_jump = can_jump
    @current_pos = start_pos
    @piece_num = piece_num
    @last_pos = []
    @next_moves = []
  end

  def color_code
    @color == :white ? 39 : 30
  end

  def determine_next_moves(squares)
    @next_moves = []
    squares.square_array.each do |square|
      @next_moves.push([square.column, square.row]) if move_to(square.column, square.row, squares) == :allow_move
    end
  end

  # protected

  def move_to(target_column, target_row, squares)
    move_checks1 = move_checks1(target_column, target_row, squares)
    return move_checks1 unless move_checks1 == :allow_move

    move_checks2 = move_checks2(target_column, target_row, squares)
    return move_checks2 unless move_checks2 == :allow_move

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
end
