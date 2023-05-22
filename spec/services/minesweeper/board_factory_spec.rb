# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Minesweeper::BoardFactory, type: :service do
  describe '#produce' do
    it 'produces board' do
      board = described_class.produce

      expect(board.class).to eq(Minesweeper::Board)
    end

    it 'produces 3x4 board with 6 mines' do
      width = 3
      height = 4
      board_factory = described_class.new(width:, height:)
      board_factory.produce

      result = [width, height]
      expect([board_factory.matrix.first.size, board_factory.matrix.size]).to eq(result)
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
