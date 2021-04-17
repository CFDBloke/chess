# frozen_string_literal: true

require_relative '../lib/piece'
require_relative '../lib/string'

# The pawn playing piece
class Pawn < Piece
  attr_accessor :id, :piece_hash, :first_move

  def initialize(player_num, color, piece_num, start_pos, can_jump)
    super(player_num, color, piece_num, start_pos, can_jump)
    @id = "P#{piece_num}"
    @first_move = true
    @move_distance = @first_move ? 2 : 1
    @piece_hash = { 1 => "       #{@id}",
                    2 => '         ',
                    3 => '    O    ',
                    4 => '   /_\   ' }
  end

  def pawn_move(target_column, target_row, squares)
    move_distance(target_column)

    return :wrong_direction unless right_direction?(target_column, target_row)

    diagonal = target_on_diagonal_axis?(target_column, target_row)
    attacking = attacking_foe?(target_column, target_row, squares)

    return :no_attack if !diagonal && attacking

    return :no_foe if diagonal && !attacking

    :allow_move
  end

  # private

  def move_distance(target_column)
    @move_distance = @first_move && target_on_vertical_axis?(target_column) ? 2 : 1
  end

  def target_on_axis?(target_column, target_row)
    target_on_vertical_axis?(target_column) || target_on_diagonal_axis?(target_column, target_row)
  end

  def right_direction?(target_column, target_row)
    allowable_directions = @player_num == 1 ? %i[North NorthEast NorthWest] : %i[South SouthEast SouthWest]
    allowable_directions.any?(movement_direction(target_column, target_row))
  end

  def attacking_foe?(target_column, target_row, squares)
    target_piece = squares.square(target_column, target_row).piece

    return false if target_piece.nil?

    squares.square(target_column, target_row).piece.player_num != @player_num
  end
end
