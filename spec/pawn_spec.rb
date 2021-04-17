# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/pawn'
require_relative '../lib/square_controller'

describe Pawn do
  subject(:player1_pawn) { described_class.new(1, :white, 1, [4, 7], false) }

  it 'has been instantiated' do
    expect(player1_pawn).to be_a(Pawn)
  end

  describe '#move_distance' do
    context 'This is the first time the pawn has been moved' do
      it 'returns 2 when moved in a vertical direction' do
        target_column = 4
        expect(player1_pawn.move_distance(target_column)).to eql(2)
      end

      it 'returns 1 when moved in a diagonal direction' do
        target_column = 3
        expect(player1_pawn.move_distance(target_column)).to eql(1)
      end
    end

    context 'This is not the first time the pawn has been moved' do
      before do
        player1_pawn.instance_variable_set(:@first_move, false)
      end

      it 'returns 1 when moved in a vertical direction' do
        target_column = 4
        expect(player1_pawn.move_distance(target_column)).to eql(1)
      end

      it 'returns 1 when moved in a diagonal direction' do
        target_column = 3
        expect(player1_pawn.move_distance(target_column)).to eql(1)
      end
    end
  end

  describe '#right_direction?' do
    context 'A player 1 pawn moves upwards' do
      it 'returns true' do
        target_column = 4
        target_row = 5
        expect(player1_pawn.right_direction?(target_column, target_row)).to be(true)
      end
    end

    context 'A player 1 pawn moves downwards' do
      it 'returns false' do
        target_column = 4
        target_row = 8
        expect(player1_pawn.right_direction?(target_column, target_row)).to be(false)
      end
    end

    let(:player2_pawn) { described_class.new(2, :black, 1, [4, 2], false) }

    context 'A player 2 pawn moves upwards' do
      it 'returns false' do
        target_column = 4
        target_row = 1
        expect(player2_pawn.right_direction?(target_column, target_row)).to be(false)
      end
    end

    context 'A player 2 pawn moves downwards' do
      it 'returns true' do
        target_column = 4
        target_row = 4
        expect(player2_pawn.right_direction?(target_column, target_row)).to be(true)
      end
    end
  end

  describe '#attacking_foe?' do
    let(:predator_pawn) { described_class.new(1, :white, 1, [4, 7], false) }
    let(:prey_pawn) { described_class.new(2, :black, 1, [3, 6], false) }

    context 'when one piece attacks another from a diagonal position' do
      it 'returns true' do
        target_column = 3
        target_row = 6
        squares = SquareController.new
        squares.square(4, 7).piece = predator_pawn
        squares.square(target_column, target_row).piece = prey_pawn
        expect(predator_pawn.attacking_foe?(target_column, target_row, squares)).to be(true)
      end
    end

    context 'when a piece is moving to an empty sqaure' do
      it 'returns false' do
        target_column = 3
        target_row = 6
        squares = SquareController.new
        squares.square(4, 7).piece = predator_pawn
        expect(predator_pawn.attacking_foe?(target_column, target_row, squares)).to be(false)
      end
    end

    context 'when one piece is looking to attack a friendly piece' do
      let(:friendly_pawn) { described_class.new(1, :white, 2, [3, 6], false) }
      it 'returns false' do
        target_column = 3
        target_row = 6
        squares = SquareController.new
        squares.square(4, 7).piece = predator_pawn
        squares.square(target_column, target_row).piece = friendly_pawn
        expect(predator_pawn.attacking_foe?(target_column, target_row, squares)).to be(false)
      end
    end
  end

  describe '#pawn_move' do
    let(:predator_pawn) { described_class.new(1, :white, 1, [4, 7], false) }
    let(:prey_pawn) { described_class.new(2, :black, 1, [4, 6], false) }

    context 'one piece tries to attack another piece directly in front of it' do
      it 'returns :no_attack' do
        target_column = 4
        target_row = 6
        squares = SquareController.new
        squares.square(4, 7).piece = predator_pawn
        squares.square(target_column, target_row).piece = prey_pawn
        expect(predator_pawn.pawn_move(target_column, target_row, squares)).to eql(:no_attack)
      end
    end

    context 'one piece tries to move diagonally when there is no foe to attack' do
      it 'returns :no_foe' do
        target_column = 3
        target_row = 6
        squares = SquareController.new
        squares.square(4, 7).piece = predator_pawn
        expect(predator_pawn.pawn_move(target_column, target_row, squares)).to eql(:no_foe)
      end
    end

    context 'when one piece attacks another from a diagonal position' do
      it 'returns :allow_move' do
        target_column = 3
        target_row = 6
        squares = SquareController.new
        squares.square(4, 7).piece = predator_pawn
        squares.square(target_column, target_row).piece = prey_pawn
        expect(predator_pawn.pawn_move(target_column, target_row, squares)).to eql(:allow_move)
      end
    end
  end
end
