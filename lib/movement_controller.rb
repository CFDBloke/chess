# frozen_string_literal: true

require_relative '../lib/square_controller'
require_relative '../lib/player'
require_relative '../lib/piece'

INPUT_FORMAT = /[bknpqrBKNPQR][1-8]?([,\s]{1}|,\s)[1-8]([,\s]{1}|,\s)[1-8]/x.freeze

# Controls the movement of all of the pieces on the chess board
class MovementController
  attr_accessor :squares, :check_mate, :player1, :player2

  def initialize
    @squares = SquareController.new
    @player1 = Player.new(1)
    @player2 = Player.new(2)
    @check_mate = false
    setup_board
    find_possible_moves
  end

  def move_piece(player_num, input_string)
    return :no_input unless valid_input?(input_string)

    parsed_input = parse_input(input_string)

    return :no_piece unless real_piece?(player_num, parsed_input[0])

    piece_to_move = get_piece(player_num, parsed_input[0])

    return :no_move unless move_legal?(piece_to_move, parsed_input[1])

    process_input(piece_to_move, parsed_input[1])
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
    aggresive_player = player_num == 1 ? @player2 : @player1

    defensive_player.pieces['K'].current_pos
    aggresive_player.opponent_check?(defensive_player.pieces['K'].current_pos)
  end

  # private

  def process_input(piece_to_move, target_pos)
    clear_square(piece_to_move.current_pos)

    piece_to_move.current_pos = target_pos

    update_square(piece_to_move)
  end

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
      obstructed: 'The path to that position is obstructed by one or more other playing pieces, please try again',
      wrong_direction: 'The pawn cannot move backwards, please try again',
      no_attack: 'The pawn cannot attack a piece that is directly ahead of it, please try again',
      no_foe: 'The pawn cannot move diagonally unless it is attacking an opposing piece, please try again'
    }
    puts error_messages[move_status]
  end

  def clear_square(sqr)
    @squares.square(sqr[0], sqr[1]).piece = nil
  end

  def update_square(predator_piece)
    target_column = predator_piece.current_pos[0]
    target_row = predator_piece.current_pos[1]

    prey_piece = @squares.square(target_column, target_row).piece

    determine_victim(predator_piece, prey_piece) unless prey_piece.nil?

    @squares.square(target_column, target_row).piece = predator_piece
  end

  def determine_victim(predator_piece, prey_piece)
    victim_player = prey_piece.player_num == 1 ? @player1 : @player2
    victim_player.delete_piece(prey_piece)
    puts "Player #{predator_piece.player_num}'s '#{predator_piece.id}' piece just took player "\
         "#{prey_piece.player_num}'s '#{prey_piece.id}' piece"
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

  def valid_input?(input_string)
    input_string.match?(INPUT_FORMAT)
  end

  def real_piece?(player_num, piece_id)
    moving_player = player_num == 1 ? @player1 : @player2

    moving_player.piece_exists?(piece_id)
  end

  def parse_input(input_string)
    input_array = input_string.split(/,\s|,|\s/)

    target_pos = [input_array[1].to_i, input_array[2].to_i]

    [input_array[0], target_pos]
  end
end
