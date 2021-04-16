# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/knight'

describe Knight do
  subject(:player1_knight) { described_class.new(1, :white, 1, [4, 4]) }
  subject(:player2_knight) { described_class.new(2, :black, 1, [5, 5]) }

  it 'has been instantiated' do
    expect(player1_knight).to be_a(Knight)
  end

  describe '#target_on_axis?' do
    context 'when player 1 chooses a target an appropriate target' do
      it 'returns true' do
        target_column = 6
        target_row = 5
        expect(player1_knight.target_on_axis?(target_column, target_row)).to be(true)
      end
    end

    context 'when player 2 chooses a target an appropriate target' do
      it 'returns true' do
        target_column = 4
        target_row = 3
        expect(player2_knight.target_on_axis?(target_column, target_row)).to be(true)
      end
    end

    context 'when player 1 chooses a target an inappropriate target' do
      it 'returns false' do
        target_column = 4
        target_row = 5
        expect(player1_knight.target_on_axis?(target_column, target_row)).to be(false)
      end
    end

    context 'when player 2 chooses a target an inappropriate target' do
      it 'returns false' do
        target_column = 5
        target_row = 6
        expect(player2_knight.target_on_axis?(target_column, target_row)).to be(false)
      end
    end
  end
end
