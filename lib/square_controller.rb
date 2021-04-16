# frozen_string_literal: true

require_relative '../lib/square'
require_relative '../lib/piece'

# The list of squares on the chessboard
class SquareController
  attr_reader :square_array

  def initialize
    @square_array = []
    build_square_list
    @size = @square_array.length
  end

  def square(column, row)
    sq = @square_array.select { |square| square.column == column && square.row == row }
    sq[0]
  end

  private

  def build_square_list
    8.times do |column|
      8.times do |row|
        @square_array.push(Square.new(column + 1, row + 1))
      end
    end
  end
end
