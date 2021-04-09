# frozen_string_literal: true

require_relative '../lib/piece'
require_relative '../lib/string'

# The knight playing piece
class Knight < Piece
  def initialize(player_num, color, piece_num, start_pos)
    super(player_num, color, piece_num, start_pos)
    @id = "N#{piece_num}"
    @piece_hash = { 1 => "          #{@id}",
                    2 => '    /\__     ',
                    3 => '   /    )    ',
                    4 => '  /__/)  )   ',
                    5 => '     /    \  ',
                    6 => '    /______\ ' }
  end
end

knight = Knight.new(1, :black, 1, [1, 1])

6.times { |num| knight.draw(num + 1, :green) }
