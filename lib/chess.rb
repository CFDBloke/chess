# frozen_string_literal: true

require_relative '../lib/chess_board'

INPUT_FORMAT = /[bknpqrBKNPQR][1-8]?([,\s]{1}|,\s)[1-8]([,\s]{1}|,\s)[1-8]/x.freeze

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
      unless valid_input?(player_input)
        repeat_input(player_num, :no_move)
        return
      end

      parsed_input = parse_input(player_input)
      make_move(parsed_input[0], parsed_input[1], player_num)
    end
  end

  def make_move(piece_id, target_pos, player_num)
    move_status = @chess_board.movement_controller.move_piece(piece_id, target_pos, player_num)
    case move_status
    when :no_piece
      repeat_input(player_num, move_status)
    when :no_move
      request_input(player_num)
    else
      @chess_board.movement_controller.find_possible_moves

      current_player_check = @chess_board.movement_controller.in_check?(player_num)

      if current_player_check
        puts 'That move is not allowed as it would leave your own king in check, please try again'
        @chess_board.movement_controller.return_piece(piece_id, player_num)
        request_input(player_num)
        return
      end

      opposing_player_check = @chess_board.movement_controller.in_check?(other_player(player_num))

      in_check_mate = @chess_board.movement_controller.check_mate?(other_player(player_num))

      if opposing_player_check && !in_check_mate
        puts 'CHECK!!'.colorize(33).colorize(1)
      elsif in_check_mate
        puts 'CHECK MATE!!!'.colorize(31).colorize(1)
        puts "Sorry Player #{other_player(player_num)}, you lose!!"
        @chess_board.movement_controller.check_mate = true
      end

      @chess_board.movement_controller.toggle_first_move(piece_id, player_num)
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

  def parse_input(input_string)
    input_array = input_string.split(/,\s|,|\s/)

    target_pos = [input_array[1].to_i, input_array[2].to_i]

    [input_array[0], target_pos]
  end

  def valid_input?(input_string)
    input_string.match?(INPUT_FORMAT)
  end

  def other_player(player_num)
    player_num == 1 ? 2 : 1
  end

  def current_player(player_num)
    player_num == 1 ? 1 : 2
  end
end

Chess.new
