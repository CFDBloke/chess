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
    @number = number
    @color = @number == 1 ? :white : :black
    @pieces = {}
    generate_pieces
  end

  def delete_piece(dead_piece)
    @pieces.delete(dead_piece.id)
  end

  def piece_exists?(piece_id)
    @pieces.any? { |key, _piece| key == piece_id }
  end

  def opponent_check?(opposing_king_pos)
    threats = []
    @pieces.each do |_key, piece|
      piece.next_moves.each do |move|
        opposing_king_pos == move ? threats.push(move) : threats
      end
    end
    !threats.empty?
  end

  private

  def generate_pieces
    start_row = @number == 1 ? 7 : 2
    generate_piece_types(Pawn, start_row, [1, 2, 3, 4, 5, 6, 7, 8])
    start_row = @number == 1 ? 8 : 1
    generate_piece_types(Bishop, start_row, [3, 6])
    generate_piece_types(King, start_row, [5])
    generate_piece_types(Knight, start_row, [2, 7], can_jump: true)
    generate_piece_types(Queen, start_row, [4])
    generate_piece_types(Rook, start_row, [1, 8])
  end

  def generate_piece_types(piece_class, start_row, columns, can_jump: false)
    columns.length.times do |piece_num|
      new_piece = piece_class.new(@number, @color, piece_num + 1, [columns[piece_num], start_row], can_jump)
      @pieces[new_piece.id] = new_piece
    end
  end
end
