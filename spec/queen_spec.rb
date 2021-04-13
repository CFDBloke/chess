# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/queen'

describe Queen do
  subject(:player1_queen) { described_class.new(1, :white, 1, [4, 8]) }
  subject(:player2_queen) { described_class.new(2, :black, 1, [4, 1]) }

  it 'has been instantiated' do
    expect(player1_queen).to be_a(Queen)
  end

  describe '#target_on_axis?' do
    context 'when the player 1 chooses a target on a vertical axis' do
      it 'returns true' do
        target_column = 4
        target_row = 4
        expect(player1_queen.target_on_axis?(target_column, target_row)).to be(true)
      end
    end

    context 'when the player 2 chooses a target on a vertical axis' do
      it 'returns true' do
        target_column = 4
        target_row = 4
        expect(player2_queen.target_on_axis?(target_column, target_row)).to be(true)
      end
    end

    context 'when the player 1 chooses a target on a horizontal axis' do
      it 'returns true' do
        target_column = 8
        target_row = 8
        expect(player1_queen.target_on_axis?(target_column, target_row)).to be(true)
      end
    end

    context 'when the player 2 chooses a target on a horizontal axis' do
      it 'returns true' do
        target_column = 8
        target_row = 1
        expect(player2_queen.target_on_axis?(target_column, target_row)).to be(true)
      end
    end

    context 'when the player 1 chooses a target on a diagonal axis' do
      it 'returns true' do
        target_column = 8
        target_row = 4
        expect(player1_queen.target_on_axis?(target_column, target_row)).to be(true)
      end
    end

    context 'when the player 2 chooses a target on a diagonal axis' do
      it 'returns true' do
        target_column = 8
        target_row = 5
        expect(player2_queen.target_on_axis?(target_column, target_row)).to be(true)
      end
    end

    context 'when the player 1 chooses a target not on any axis' do
      it 'returns false' do
        target_column = 1
        target_row = 7
        expect(player1_queen.target_on_axis?(target_column, target_row)).to be(false)
      end
    end

    context 'when the player 2 chooses a target not on any axis' do
      it 'returns false' do
        target_column = 8
        target_row = 2
        expect(player1_queen.target_on_axis?(target_column, target_row)).to be(false)
      end
    end
  end
end
