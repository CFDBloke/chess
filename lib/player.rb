# frozen_string_literal: true

require_relative '../lib/bishop'
require_relative '../lib/king'
require_relative '../lib/knight'
require_relative '../lib/pawn'
require_relative '../lib/queen'
require_relative '../lib/rook'

# Identifies each player and their pieces that are still in play
class Player
  def initialize(name, number)
    @name = name
    @number = number
    @color = @number == 1 ? :white : :black
    @bishops = generate_bishops
    @king = generate_king
  end

  private

  def generate_bishops
    start_positions = @number == 1 ? [[3, 8], [6, 8]] : [[3, 1], [6, 1]]
    new_bishop1 = Bishop.new(@number, @color, 1, start_positions[0])
    new_bishop2 = Bishop.new(@number, @color, 2, start_positions[1])
    [new_bishop1, new_bishop2]
  end

  def generate_king
    start_position = @number == 1 ? [5, 8] : [5, 1]
    King.new(@number, @color, 1, start_position)
  end
end
