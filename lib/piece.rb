# frozen_string_literal: true

# A generic playing piece. All other piece types inherit from this piece
class Piece
  def initialize(player_num, color, piece_num, start_pos)
    @player_num = player_num
    @color = color
    @current_pos = start_pos
    @piece_num = piece_num
  end

  def draw(row, bg_color)
    bg_color_code = bg_color == :yellow ? 43 : 42

    puts @piece_hash[row].colorize(color_code).colorize(bg_color_code).colorize(1)
  end

  private

  def color_code
    @color == :white ? 39 : 30
  end
end
