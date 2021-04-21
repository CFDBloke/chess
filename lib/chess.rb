# frozen_string_literal: true

require_relative '../lib/chess_board'

# The controlling class for the whole game
class Chess
  def initialize
    @chess_board = ChessBoard.new
    start_game
  end

  def start_game
    puts 'Welcome to Ruby Chess!'

    puts 'Here is your board set up and ready to go...'

    @chess_board.draw

    puts 'For instructions on how to move pieces, just enter \'help\' at any time, but for now lets get started...'

    execute_gameplay
  end

  private

  def execute_gameplay
    until @chess_board.movement_controller.check_mate
      request_input(1)
      request_input(2)
    end
  end

  def request_input(player_num)
    puts "Player #{player_num}, please make a move"
    process_input(gets, player_num)
  end

  def process_input(player_input, player_num)
    case player_input.downcase
    when 'help'
      display_help
      request_input(player_num)
    when 'save'
      save_game
      request_input(player_num)
    else
      make_move(player_input, player_num)
    end
  end

  def make_move(player_input, player_num)
    move_status = @chess_board.movement_controller.move_piece(player_num, player_input)
    case move_status
    when :no_input, :no_piece
      repeat_input(player_num, move_status)
    when :no_move
      request_input(player_num)
    else
      @chess_board.movement_controller.find_possible_moves

      
      # Place check here to determine if either kings are in check
      # If the current players king is in check then reverse the move as it is illegal
      # If the opposing player is in check then check opposing players move options
      # If the opposing player can move out of check then declare check and continue play
      # If the oppoing player cannot move out of check then declare check mate
      @chess_board.draw
    end
  end

  def repeat_input(player_num, move_status)
    if move_status == :no_input
      puts 'Input not recognized, please try again'
    else
      puts 'That piece doesn\'t exist, please try again'
    end
    request_input(player_num)
  end
end

Chess.new
