# frozen_string_literal: true

require_relative '../lib/movement_controller'

# The class for displaying the chessboard
class ChessBoard
  def initialize
    @movement_controller = MovementController.new
    draw
    # @movement_controller.move_piece(1, 'Q, 8, 4')
    # draw
  end

  def draw
    8.times do |row_number|
      print '---------'
      8.times { draw_row_top }
      print "+\n"
      draw_board_row(row_number)
    end
    print '---------'
    8.times { draw_row_top }
    print "+\n"
    draw_row_bottom
  end

  private

  def draw_row_top
    print '+---------'
  end

  def draw_row_bottom
    4.times do |row|
      print '         |'
      8.times do |num|
        draw_number_row(num + 1, row + 1)
        print '|'
      end
      print "\n"
    end
  end

  def draw_board_row(row_number)
    4.times do |row|
      draw_number_row(row_number + 1, row + 1)
      8.times do |column|
        @movement_controller.vertices.square(column + 1, row_number + 1).draw(row + 1)
      end
      print "|\n"
    end
  end

  def draw_number_row(number, row)
    row = row.between?(5, 6) ? 5 : row
    number_hash = { 1 => { 1 => '         ', 2 => '    |    ', 3 => '    |    ', 4 => '         ' },
                    2 => { 1 => '   __    ', 2 => '   __|   ', 3 => '  |__    ', 4 => '         ' },
                    3 => { 1 => '   __    ', 2 => '   __|   ', 3 => '   __|   ', 4 => '         ' },
                    4 => { 1 => '         ', 2 => '  |__|   ', 3 => '     |   ', 4 => '         ' },
                    5 => { 1 => '   __    ', 2 => '  |__    ', 3 => '   __|   ', 4 => '         ' },
                    6 => { 1 => '   __    ', 2 => '  |__    ', 3 => '  |__|   ', 4 => '         ' },
                    7 => { 1 => '   __    ', 2 => '     |   ', 3 => '     |   ', 4 => '         ' },
                    8 => { 1 => '   __    ', 2 => '  |__|   ', 3 => '  |__|   ', 4 => '         ' } }
    print number_hash[number][row]
  end
end

ChessBoard.new
