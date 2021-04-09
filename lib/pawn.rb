# frozen_string_literal: true

require_relative '../lib/piece'
require_relative '../lib/string'

# The pawn playing piece
class Pawn < Piece
  def initialize(player_num, color, piece_num, start_pos)
    super(player_num, color, piece_num, start_pos)
    @id = "P#{piece_num}"
    @piece_hash = { 1 => "           #{@id}",
                    2 => '     ___     ',
                    3 => '    |___|    ',
                    4 => '    /   \    ',
                    5 => '   /_____\   ',
                    6 => '             ' }
  end
end

pawn = Pawn.new(1, :black, 1, [1, 1])

6.times { |num| pawn.draw(num + 1, :green) }
