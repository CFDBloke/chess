# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/movement_controller'

describe MovementController do
  subject(:movement_controller) { described_class.new }

  it 'has been instantiated' do
    expect(movement_controller).to be_a(MovementController)
  end

  describe '#parse_input' do
    context 'when a comma only is used between the inputs' do
      it 'returns the correct output array' do
        input_string = 'N2,5,5'
        expect(movement_controller.parse_input(input_string)).to eql(['N2', [5, 5]])
      end
    end

    context 'when a space only is used between the inputs' do
      it 'returns the correct output array' do
        input_string = 'N2 5 5'
        expect(movement_controller.parse_input(input_string)).to eql(['N2', [5, 5]])
      end
    end

    context 'when a comma and a space is used between the inputs' do
      it 'returns the correct output array' do
        input_string = 'N2, 5, 5'
        expect(movement_controller.parse_input(input_string)).to eql(['N2', [5, 5]])
      end
    end
  end

  describe '#valid_input?' do
    context 'when a comma only is used between the inputs' do
      it "returns true for input 'N2,5,5'" do
        input_string = 'N2,5,5'
        expect(movement_controller.valid_input?(input_string)).to be(true)
      end
    end

    context 'when a space only is used between the inputs' do
      it "returns true for input 'N2 5 5'" do
        input_string = 'N2 5 5'
        expect(movement_controller.valid_input?(input_string)).to be(true)
      end
    end

    context 'when a comma and a space is used between the inputs' do
      it "returns true for input 'N2, 5, 5'" do
        input_string = 'N2, 5, 5'
        expect(movement_controller.valid_input?(input_string)).to be(true)
      end
    end

    context 'when the piece being moved is the king' do
      it "returns true for input 'K, 5, 5'" do
        input_string = 'K, 5, 5'
        expect(movement_controller.valid_input?(input_string)).to be(true)
      end
    end

    context 'when an input is isn\'t valid' do
      it "returns false for input '2, 5, 5' because the piece designation is missing" do
        input_string = '2, 5, 5'
        expect(movement_controller.valid_input?(input_string)).to be(false)
      end

      it "returns false for input 'D2, 5, 5' because the piece designation is wrong" do
        input_string = 'D2, 5, 5'
        expect(movement_controller.valid_input?(input_string)).to be(false)
      end

      it "returns false for input 'N2, a, 5' because the column designation isn't a number" do
        input_string = 'N2, a, 5'
        expect(movement_controller.valid_input?(input_string)).to be(false)
      end

      it "returns false for input 'N2, 5, a' because the row designation isn't a number" do
        input_string = 'N2, a, 5'
        expect(movement_controller.valid_input?(input_string)).to be(false)
      end

      it "returns false for input 'fgdftsd' because the cat walked on the keyboard" do
        input_string = 'fgdftsd'
        expect(movement_controller.valid_input?(input_string)).to be(false)
      end
    end
  end

  describe '#in_check?' do
    let(:player1) { movement_controller.player1 }
    let(:player2) { movement_controller.player2 }
    let(:player2_king) { player2.pieces['K'] }
    let(:player1_knight) { player1.pieces['N1'] }
    context 'when the opponents king is not threatened by one of your players' do
      it 'returns false' do
        expect(movement_controller.in_check?(2)).to be(false)
      end
    end

    context 'when the opponents king is threatened by one of your players' do
      it 'returns true' do
        player2_king.current_pos = [6, 6]
        player1_knight.next_moves = [[6, 6], [8, 6]]
        expect(movement_controller.in_check?(2)).to be(true)
      end
    end
  end
end
