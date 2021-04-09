# frozen_string_literal: true

require_relative '../lib/piece'
require_relative '../lib/string'

# The bishop playing piece
class Bishop < Piece
  def initialize(player_num, color, piece_num, start_pos)
    super(player_num, color, piece_num, start_pos)
    @id = "B#{piece_num}"
    @piece_hash = { 1 => "          #{@id}",
                    2 => '      O      ',
                    3 => '     ( )     ',
                    4 => '     \ /     ',
                    5 => '     | |     ',
                    6 => '    /___\    ' }
  end
end

bishop = Bishop.new(1, :black, 1, [1, 1])

6.times { |num| bishop.draw(num + 1, :green) }
