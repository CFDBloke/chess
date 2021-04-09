# frozen_string_literal: true

require_relative '../lib/piece'
require_relative '../lib/string'

# The queen playing piece
class Queen < Piece
  def initialize(player_num, color, piece_num, start_pos)
    super(player_num, color, piece_num, start_pos)
    @id = 'Q'
    @piece_hash = { 1 => "    _/O\\_   #{@id}",
                    2 => '    \   /    ',
                    3 => '     \ /     ',
                    4 => '     | |     ',
                    5 => '     | |     ',
                    6 => '    /___\    ' }
  end
end

queen = Queen.new(1, :white, 1, [1, 1])

6.times { |num| queen.draw(num + 1, :yellow) }
