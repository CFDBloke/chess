# frozen_string_literal: true

# A generic playing piece. All other piece types inherit from this piece
class Piece
  def initialize(player_num, color, piece_num, start_pos)
    @player_num = player_num
    @color = color
    @current_pos = start_pos
    @piece_num = piece_num
  end
end
