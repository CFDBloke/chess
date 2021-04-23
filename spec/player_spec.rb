# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/player'
require_relative '../lib/knight'

describe Player do
  subject(:player1) { described_class.new(1) }
  let(:player1_knight) { player1.pieces['N2'] }

  it 'has been instantiated' do
    expect(player1).to be_a(Player)
  end

  describe '#delete_piece' do
    context 'when the knight \'N2\' gets taken by the other player' do
      it 'removes the piece from the pieces hash' do
        player1.delete_piece(player1_knight)
        expect(player1.pieces).not_to include(player1_knight.id)
      end
    end

    context 'when the knight \'N2\' doesn\'t get taken by the other player' do
      it 'doesn\'t remove the piece from the pieces hash' do
        expect(player1.pieces).to include(player1_knight.id)
      end
    end
  end

  describe '#piece_exists?' do
    context 'when the knight still exists within the players pieces hash' do
      it 'returns true' do
        expect(player1.piece_exists?(player1_knight.id)).to be(true)
      end
    end

    context 'when the knight no longer exists within the players pieces hash' do
      it 'returns false' do
        player1.delete_piece(player1_knight)
        expect(player1.piece_exists?(player1_knight.id)).to be(false)
      end
    end
  end

  describe '#opponent_check?' do
    let(:player2) { described_class.new(2) }
    let(:player2_king) { player2.pieces['K'] }
    context 'when the opponents king is not threatened by one of your players' do
      it 'returns false' do
        expect(player1.opponent_check?(player2_king.current_pos)).to be(false)
      end
    end

    context 'when the opponents king is threatened by one of your players' do
      it 'returns true' do
        player2_king.current_pos = [6, 6]
        player1_knight.next_moves = [[6, 6], [8, 6]]
        expect(player1.opponent_check?(player2_king.current_pos)).to be(true)
      end
    end
  end
end
