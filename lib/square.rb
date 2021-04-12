# frozen_string_literal: true

require_relative '../lib/bishop'
require_relative '../lib/king'
require_relative '../lib/knight'
require_relative '../lib/pawn'
require_relative '../lib/queen'
require_relative '../lib/rook'

# Representation of a square on the chess board
class Square
  attr_accessor :row, :column, :position, :piece

  def initialize(column, row, piece = nil)
    @row = row
    @column = column
    @position = [column, row]
    @bg_color = bg_color
    @piece = piece
  end

  def draw(row_to_draw)
    bg_color_code = @bg_color == :yellow ? 43 : 42

    if piece.nil?
      print "|#{'         '.colorize(bg_color_code).colorize(1)}"
    else
      print "|#{draw_piece_row(row_to_draw, bg_color_code)}"
    end
  end

  private

  def bg_color
    @column.even? && @row.even? || @column.odd? && @row.odd? ? :yellow : :green
  end

  def draw_piece_row(row_to_draw, bg_color_code)
    @piece.piece_hash[row_to_draw].colorize(@piece.color_code).colorize(bg_color_code).colorize(1)
  end
end
