# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Minesweeper::BoardFactory, type: :service do
  describe '#produce' do
    it 'produces board' do
      board = described_class.produce(width: 5, height: 5, mines: 5)

      expect(board.class).to eq(Minesweeper::Board)
    end

    it 'fails to produce a board with width less than 2' do
      expect do
        described_class.produce(width: 1, height: 5, mines: 1)
      end.to raise_error(Minesweeper::BoardFactory::MinWidthError)
    end

    it 'fails to produce a board with height less than 2' do
      expect do
        described_class.produce(width: 5, height: 1, mines: 1)
      end.to raise_error(Minesweeper::BoardFactory::MinHeightError)
    end

    it 'fails to produce a board with mines below limit' do
      expect do
        described_class.produce(width: 5, height: 5, mines: 0)
      end.to raise_error(Minesweeper::BoardFactory::MinMinesError)
    end

    it 'fails to produce a board with mines above limit' do
      expect do
        described_class.produce(width: 5, height: 5, mines: 100)
      end.to raise_error(Minesweeper::BoardFactory::MaxMinesError)
    end
  end
end
