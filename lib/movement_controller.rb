# frozen_string_literal: true

require_relative '../lib/vertex_list'
require_relative '../lib/player'

# Controls the movement of all of the pieces on the chess board
class MovementController
  attr_accessor :vertices

  def initialize
    @vertices = VertexList.new
    @player1 = Player.new(1)
    @player2 = Player.new(2)
    setup_board
  end

  def move_piece(player_num, input_string)
    input_array = input_string.split(',')

    piece_to_move = get_piece(player_num, input_array[0])

    clear_square(piece_to_move.current_pos)

    piece_to_move.current_pos = [input_array[1].to_i, input_array[2].to_i]

    update_square(piece_to_move)
  end

  private

  def clear_square(sqr)
    @vertices.square(sqr[0], sqr[1]).piece = nil
  end

  def update_square(piece)
    @vertices.square(piece.current_pos[0], piece.current_pos[1]).piece = piece
  end

  def setup_board
    setup_pieces(@player1)
    setup_pieces(@player2)
  end

  def setup_pieces(player)
    player.pieces.each do |_key, piece|
      @vertices.square(piece.current_pos[0], piece.current_pos[1]).piece = piece
    end
  end

  def get_piece(player_num, piece_id)
    player = player_num == 1 ? @player1 : @player2
    player.pieces[piece_id]
  end
end
