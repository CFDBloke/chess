# frozen_string_literal: true

require_relative '../lib/square_controller'
require_relative '../lib/player'

# Controls the movement of all of the pieces on the chess board
class MovementController
  attr_accessor :squares

  def initialize
    @squares = SquareController.new
    @player1 = Player.new(1)
    @player2 = Player.new(2)
    setup_board
  end

  def move_piece(player_num, input_string)
    input_array = input_string.split(',')

    target_pos = [input_array[1].to_i, input_array[2].to_i]

    piece_to_move = get_piece(player_num, input_array[0])

    return :no_move unless move_legal?(piece_to_move, target_pos)

    clear_square(piece_to_move.current_pos)

    piece_to_move.current_pos = target_pos

    update_square(piece_to_move)
  end

  private

  def move_legal?(piece_to_move, target_pos)
    move_status = piece_to_move.move_to(target_pos[0], target_pos[1], @squares)

    return true if move_status == :allow_move

    move_error(move_status)
    false
  end

  def move_error(move_status)
    error_messages = {
      invalid: 'You appear to have chosen a target that doesn\'t exist on the game board, please try again',
      no_axis: 'That piece cannot move to that position in one move, please try again',
      too_far: 'That piece cannot move that far, please try again',
      friendly: 'One of your own pieces is already at that location, please try again',
      obstructed: 'The path to that position is obstructed by one or more other playing pieces, please try again'
    }
    puts error_messages[move_status]
  end

  def clear_square(sqr)
    @squares.square(sqr[0], sqr[1]).piece = nil
  end

  def update_square(piece)
    @squares.square(piece.current_pos[0], piece.current_pos[1]).piece = piece
  end

  def setup_board
    setup_pieces(@player1)
    setup_pieces(@player2)
  end

  def setup_pieces(player)
    player.pieces.each do |_key, piece|
      @squares.square(piece.current_pos[0], piece.current_pos[1]).piece = piece
    end
  end

  def get_piece(player_num, piece_id)
    player = player_num == 1 ? @player1 : @player2
    player.pieces[piece_id]
  end
end
