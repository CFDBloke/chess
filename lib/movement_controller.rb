# frozen_string_literal: true

require_relative '../lib/square_controller'
require_relative '../lib/player'
require_relative '../lib/piece'
require_relative '../lib/movement_controller_helpers'

# Controls the movement of all of the pieces on the chess board
class MovementController
  attr_accessor :squares, :check_mate, :player1, :player2

  include MovementControllerHelpers

  def initialize
    @squares = SquareController.new
    @player1 = Player.new(1)
    @player2 = Player.new(2)
    @check_mate = false
    setup_board
    find_possible_moves
  end

  def return_piece(piece_id, player_num)
    piece_to_return = get_piece(player_num, piece_id)
    reset_piece(piece_to_return)
  end

  def find_possible_moves
    player_array = [@player1, @player2]
    player_array.each do |player|
      player.pieces.each do |piece_ref|
        piece = @squares.square(piece_ref[1].current_pos[0], piece_ref[1].current_pos[1]).piece

        piece.determine_next_moves(@squares)
      end
    end
  end

  def in_check?(player_num)
    defensive_player = player_num == 1 ? @player1 : @player2
    aggressive_player = player_num == 1 ? @player2 : @player1

    defensive_player.pieces['K'].current_pos
    aggressive_player.opponent_check?(defensive_player.pieces['K'].current_pos)
  end

  def check_mate?(player_num)
    player = player_num == 1 ? @player1 : @player2

    player.pieces.each do |piece_id, piece|
      piece.next_moves.each do |possible_move|
        move_piece(piece_id, possible_move, player_num, true)
        still_in_check = in_check?(player_num)
        reset_piece(piece)
        return false unless still_in_check
      end
    end

    true
  end

  def toggle_first_move(piece_id, player_num)
    player = player_num == 1 ? @player1 : @player2

    return if piece_id[0] != 'P'

    player.pieces[piece_id].first_move = false
  end

  # private

  def setup_board
    setup_pieces(@player1)
    setup_pieces(@player2)
  end

  def setup_pieces(player)
    player.pieces.each do |_key, piece|
      @squares.square(piece.current_pos[0], piece.current_pos[1]).piece = piece
    end
  end

  def reset_piece(piece)
    @squares.square(piece.current_pos[0], piece.current_pos[1]).piece = nil
    piece.current_pos = piece.last_pos
    @squares.square(piece.current_pos[0], piece.current_pos[1]).piece = piece
  end
end
