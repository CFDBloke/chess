# frozen_string_literal: true

require_relative '../lib/piece'
require_relative '../lib/string'

# The king playing piece
class King < Piece
  def initialize(player_num, color, piece_num, start_pos)
    super(player_num, color, piece_num, start_pos)
    @id = 'K'
    @piece_hash = { 1 => "   __+|+__  #{@id}",
                    2 => '   \     /   ',
                    3 => '    |   |    ',
                    4 => '     | |     ',
                    5 => '    _| |_    ',
                    6 => '   /_____\   ' }
  end
end

king = King.new(1, :white, 1, [1, 1])

6.times { |num| king.draw(num + 1, :yellow) }
