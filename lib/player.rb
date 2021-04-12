# frozen_string_literal: true

require_relative '../lib/bishop'
require_relative '../lib/king'
require_relative '../lib/knight'
require_relative '../lib/pawn'
require_relative '../lib/queen'
require_relative '../lib/rook'

# Identifies each player and their pieces that are still in play
class Player
  attr_accessor :pieces

  def initialize(number)
    @name = 'Bob'
    @number = number
    @color = @number == 1 ? :white : :black
    @pieces = {}
    generate_pieces
  end

  private

  def generate_pieces
    generate_bishops
    generate_king
    generate_knights
    generate_pawns
    generate_queen
    generate_rooks
  end

  def generate_bishops
    start_positions = @number == 1 ? [[3, 8], [6, 8]] : [[3, 1], [6, 1]]
    2.times do |piece_num|
      new_bishop = Bishop.new(@number, @color, piece_num + 1, start_positions[piece_num])
      @pieces[new_bishop.id] = new_bishop
    end
  end

  def generate_king
    start_position = @number == 1 ? [5, 8] : [5, 1]
    king = King.new(@number, @color, 1, start_position)
    @pieces[king.id] = king
  end

  def generate_knights
    start_positions = @number == 1 ? [[2, 8], [7, 8]] : [[2, 1], [7, 1]]
    2.times do |piece_num|
      new_knight = Knight.new(@number, @color, piece_num + 1, start_positions[piece_num])
      @pieces[new_knight.id] = new_knight
    end
  end

  def generate_pawns
    start_row = @number == 1 ? 7 : 2
    8.times do |piece_num|
      new_pawn = Pawn.new(@number, @color, piece_num + 1, [piece_num + 1, start_row])
      @pieces[new_pawn.id] = new_pawn
    end
  end

  def generate_queen
    start_position = @number == 1 ? [4, 8] : [4, 1]
    queen = Queen.new(@number, @color, 1, start_position)
    @pieces[queen.id] = queen
  end

  def generate_rooks
    start_positions = @number == 1 ? [[1, 8], [8, 8]] : [[1, 1], [8, 1]]
    2.times do |piece_num|
      new_rook = Rook.new(@number, @color, piece_num + 1, start_positions[piece_num])
      @pieces[new_rook.id] = new_rook
    end
  end
end
