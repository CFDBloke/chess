# frozen_string_literal: true

# Helper methods for the movement controller class
module MovementControllerHelpers
  def move_piece(piece_id, target_pos, player_num, for_testing)
    return :no_piece unless real_piece?(player_num, piece_id)

    piece_to_move = get_piece(player_num, piece_id)
    return :no_move unless move_legal?(piece_to_move, target_pos)

    process_input(piece_to_move, target_pos, for_testing)
  end

  private

  def real_piece?(player_num, piece_id)
    moving_player = player_num == 1 ? @player1 : @player2

    moving_player.piece_exists?(piece_id)
  end

  def get_piece(player_num, piece_id)
    player = player_num == 1 ? @player1 : @player2
    player.pieces[piece_id]
  end

  def move_legal?(piece_to_move, target_pos)
    move_status = piece_to_move.move_to(target_pos[0], target_pos[1], @squares)

    return true if move_status == :allow_move

    move_error(move_status)
    false
  end

  def move_error(move_status)
    error_messages1 = %i[invalid no_axis too_far friendly]

    puts error_messages1.any?(move_status) ? errors1(move_status) : errors2(move_status)
  end

  def errors1(move_status)
    error_messages = {
      invalid: 'You appear to have chosen a target that doesn\'t exist on the game board, please try again',
      no_axis: 'That piece cannot move to that position in one move, please try again',
      too_far: 'That piece cannot move that far, please try again',
      friendly: 'One of your own pieces is already at that location, please try again'
    }
    error_messages[move_status]
  end

  def errors2(move_status)
    error_messages = {
      obstructed: 'The path to that position is obstructed by one or more other playing pieces, please try again',
      wrong_direction: 'The pawn cannot move backwards, please try again',
      no_attack: 'The pawn cannot attack a piece that is directly ahead of it, please try again',
      no_foe: 'The pawn cannot move diagonally unless it is attacking an opposing piece, please try again'
    }
    error_messages[move_status]
  end

  def process_input(piece_to_move, target_pos, for_testing)
    clear_square(piece_to_move.current_pos) unless for_testing

    piece_to_move.last_pos = piece_to_move.current_pos
    piece_to_move.current_pos = target_pos

    update_square(piece_to_move) unless for_testing
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
end
