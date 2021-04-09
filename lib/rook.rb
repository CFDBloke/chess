# frozen_string_literal: true

require_relative '../lib/piece'
require_relative '../lib/string'

# The bishop playing piece
class Rook < Piece
  def initialize(player_num, color, piece_num, start_pos)
    super(player_num, color, piece_num, start_pos)
    @id = "R#{piece_num}"
    @piece_hash = { 1 => "           #{@id}",
                    2 => '   n_n_n_n   ',
                    3 => '   \     /   ',
                    4 => '    |   |    ',
                    5 => '    |   |    ',
                    6 => '   /_____\   ' }
  end
end

rook = Rook.new(1, :black, 1, [1, 1])

6.times { |num| rook.draw(num + 1, :green) }
