# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/piece'
require_relative '../lib/queen'
require_relative '../lib/vertex_list'

describe Piece do
  subject(:player1_piece) { Queen.new(1, :white, 1, [4, 8]) }
  let(:vertex_list) { VertexList.new }

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
        expect(player1_piece.friendly_target?(target_column, target_row, vertex_list)).to be(false)
      end
    end

    context 'when the target square already has a friendly piece on it' do
      target_column = 1
      target_row = 8
      let(:friendly_piece) { Queen.new(1, :white, 1, [target_column, target_row]) }

      before do
        vertex_list.square(target_column, target_row).piece = friendly_piece
      end

      it 'returns true' do
        expect(player1_piece.friendly_target?(target_column, target_row, vertex_list)).to be(true)
      end
    end

    context 'when the target square already has an unfriendly piece on it' do
      target_column = 1
      target_row = 8
      let(:unfriendly_piece) { Queen.new(2, :black, 1, [target_column, target_row]) }

      before do
        vertex_list.square(target_column, target_row).piece = unfriendly_piece
      end

      it 'returns false' do
        expect(player1_piece.friendly_target?(target_column, target_row, vertex_list)).to be(false)
      end
    end
  end
end
