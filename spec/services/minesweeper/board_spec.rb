# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Minesweeper::Board, type: :service do
  let(:matrix) do
    [
      [Minesweeper::Cell.new, Minesweeper::Cell.new],
      [Minesweeper::Cell.new, Minesweeper::Cell.new]
    ]
  end
  let(:board) { described_class.new(matrix:, width: 2, height: 2, mines: 1) }

  describe '#set' do
    it 'reveals empty cell' do
      cell = matrix[0][0]
      board.set(0, 0)

      expect(cell.revealed?).to eq(true)
    end

    it 'returns correct empty fields count' do
      board.set(0, 0)

      expect(board.empty_fields).to eq(3)
    end

    it 'returns correct mines stepped count' do
      cell = matrix[0][0]
      allow(cell).to receive(:mine?).and_return(true)
      board.set(0, 0)

      expect(board.mines_stepped).to eq(1)
    end
  end

  describe '#revealed_matrix' do
    it 'returns revealed matrix' do
      expect(board.revealed_matrix.flatten).to all(satisfy(&:revealed?))
    end
  end
end
