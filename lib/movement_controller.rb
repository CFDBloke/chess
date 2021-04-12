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

  private

  def setup_board
    setup_pieces(@player1)
    setup_pieces(@player2)
  end

  def setup_pieces(player)
    player.pieces.each do |_key, piece|
      @vertices.square(piece.current_pos[0], piece.current_pos[1]).piece = piece
    end
  end
end
