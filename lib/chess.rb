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
    if player_input.downcase == 'help'
      display_help
      request_input(player_num)
    elsif player_input.downcase == 'save'
      save_game
      request_input(player_num)
    else
      make_move(player_input, player_num)
    end
  end

  def make_move(player_input, player_num)
    move_status = @chess_board.movement_controller.move_piece(player_num, player_input)
    move_status == :no_move ? request_input(player_num) : @chess_board.draw
  end
end

Chess.new
