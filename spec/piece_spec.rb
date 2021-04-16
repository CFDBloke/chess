# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/piece'
require_relative '../lib/queen'
require_relative '../lib/square_controller'

describe Piece do
  subject(:player1_piece) { Queen.new(1, :white, 1, [4, 8]) }
  let(:squares) { SquareController.new }

  context 'when a queen is created' do
    it 'the piece class is also instantiated' do
      expect(player1_piece).to be_a(Piece)
    end
  end

  describe '#friendly_target?' do
    context 'when the target square is empty' do
      it 'returns false' do
        target_column = 1
        target_row = 8
        expect(player1_piece.friendly_target?(target_column, target_row, squares)).to be(false)
      end
    end

    context 'when the target square already has a friendly piece on it' do
      target_column = 1
      target_row = 8
      let(:friendly_piece) { Queen.new(1, :white, 1, [target_column, target_row]) }

      before do
        squares.square(target_column, target_row).piece = friendly_piece
      end

      it 'returns true' do
        expect(player1_piece.friendly_target?(target_column, target_row, squares)).to be(true)
      end
    end

    context 'when the target square already has an unfriendly piece on it' do
      target_column = 1
      target_row = 8
      let(:unfriendly_piece) { Queen.new(2, :black, 1, [target_column, target_row]) }

      before do
        squares.square(target_column, target_row).piece = unfriendly_piece
      end

      it 'returns false' do
        expect(player1_piece.friendly_target?(target_column, target_row, squares)).to be(false)
      end
    end
  end

  describe '#movement_direction' do
    context 'when the piece is moving up the board' do
      target_column = 4
      target_row = 4

      it 'returns :North' do
        expect(player1_piece.movement_direction(target_column, target_row)).to eql(:North)
      end
    end

    context 'when the piece is moving down the board' do
      subject(:player2_piece) { Queen.new(2, :black, 1, [4, 1]) }
      target_column = 4
      target_row = 4

      it 'returns :South' do
        expect(player2_piece.movement_direction(target_column, target_row)).to eql(:South)
      end
    end

    context 'when the piece is moving across the board to the right' do
      target_column = 8
      target_row = 8

      it 'returns :East' do
        expect(player1_piece.movement_direction(target_column, target_row)).to eql(:East)
      end
    end

    context 'when the piece is moving across the board to the left' do
      target_column = 1
      target_row = 8

      it 'returns :West' do
        expect(player1_piece.movement_direction(target_column, target_row)).to eql(:West)
      end
    end

    context 'when the piece is moving across the board diagonally to the right and upwards' do
      target_column = 8
      target_row = 4

      it 'returns :NorthEast' do
        expect(player1_piece.movement_direction(target_column, target_row)).to eql(:NorthEast)
      end
    end

    context 'when the piece is moving across the board diagonally to the right and downwards' do
      subject(:player2_piece) { Queen.new(2, :black, 1, [4, 1]) }
      target_column = 8
      target_row = 5

      it 'returns :SouthEast' do
        expect(player2_piece.movement_direction(target_column, target_row)).to eql(:SouthEast)
      end
    end

    context 'when the piece is moving across the board diagonally to the left and upwards' do
      target_column = 1
      target_row = 5

      it 'returns :NorthWest' do
        expect(player1_piece.movement_direction(target_column, target_row)).to eql(:NorthWest)
      end
    end

    context 'when the piece is moving across the board diagonally to the left and downwards' do
      subject(:player2_piece) { Queen.new(2, :black, 1, [4, 1]) }
      target_column = 1
      target_row = 4

      it 'returns :SouthWest' do
        expect(player2_piece.movement_direction(target_column, target_row)).to eql(:SouthWest)
      end
    end
  end

  describe '#find_path' do
    context 'when the piece is moving up the board from [4, 8] to [4, 4]' do
      target_column = 4
      target_row = 4
      direction = :North

      it 'returns [[4, 7], [4, 6], [4, 5]]' do
        expect(player1_piece.find_path(target_column, target_row, direction)).to eql([[4, 7], [4, 6], [4, 5]])
      end
    end

    context 'when the piece is moving across the board from [4, 8] to [8, 8]' do
      target_column = 8
      target_row = 8
      direction = :East

      it 'returns [[5, 8], [6, 8], [7, 8]]' do
        expect(player1_piece.find_path(target_column, target_row, direction)).to eql([[5, 8], [6, 8], [7, 8]])
      end
    end

    context 'when the piece is moving diagonally across the board from [4, 8] to [8, 4]' do
      target_column = 8
      target_row = 4
      direction = :NorthEast

      it 'returns [[5, 7], [6, 6], [7, 5]]' do
        expect(player1_piece.find_path(target_column, target_row, direction)).to eql([[5, 7], [6, 6], [7, 5]])
      end
    end

    context 'when the piece is moving diagonally across the board just one space from [4, 8] to [3, 7]' do
      target_column = 3
      target_row = 7
      direction = :NorthWest

      it 'returns []' do
        expect(player1_piece.find_path(target_column, target_row, direction)).to eql([])
      end
    end
  end
end
