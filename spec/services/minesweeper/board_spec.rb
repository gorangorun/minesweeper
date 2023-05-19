# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Minesweeper::Board, type: :service do
  let(:matrix) { [[0, 0], [1, 0]] }
  let(:board) { described_class.new(matrix:, width: 2, height: 2, mines: 1) }

  describe '#set' do
    it 'marks field with empty mark' do
      board.set(0, 0)

      result = [
        [Minesweeper::Board::EMPTY, 0],
        [1, 0]
      ]
      expect(board.matrix).to eq(result)
    end

    it 'marks field with mine mark' do
      board.set(1, 0)

      result = [
        [0, 0],
        [Minesweeper::Board::MINE, 0]
      ]
      expect(board.matrix).to eq(result)
    end

    it 'returns correct empty fields count' do
      board.set(1, 1)

      expect(board.empty_fields).to eq(2)
    end

    it 'returns correct mines stepped count' do
      board.set(1, 0)

      expect(board.mines_stepped).to eq(1)
    end
  end

  describe '#solved_matrix' do
    it 'returns solved matrix' do
      board.set(1, 0)

      result = [
        [Minesweeper::Board::EMPTY, Minesweeper::Board::EMPTY],
        [Minesweeper::Board::MINE, Minesweeper::Board::EMPTY]
      ]
      expect(board.solved_matrix).to eq(result)
    end
  end
end
