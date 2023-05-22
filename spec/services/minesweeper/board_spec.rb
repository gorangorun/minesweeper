# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Minesweeper::Board, type: :service do
  let(:width) { 5 }
  let(:height) { 5 }
  let(:mines) { 1 }
  let(:matrix) do
    m = []
    height.times.each do |y|
      m[y] = []
      width.times.each do |x|
        m[y][x] = Minesweeper::Cell.new
      end
    end
    m
  end

  let(:board) { described_class.new(matrix:, width:, height:, mines:) }

  describe '#reveal' do
    it 'reveals adjascent cells when cell with value 0 is revealed' do
      cell = matrix[0][0]
      adjascent_cells = [matrix[0][1], matrix[1][1], matrix[1][0]]

      adjascent_cells.each do |c|
        allow(c).to receive(:value).and_return(1)
        allow(c).to receive(:blank?).and_return(false)
        allow(c).to receive(:empty?).and_return(true)
      end

      board.reveal(0, 0)
      expect([cell] + adjascent_cells).to all(satisfy(&:revealed?))
    end

    it 'returns correct empty fields count' do
      cell = matrix[0][0]
      allow(cell).to receive(:value).and_return(1)
      allow(cell).to receive(:blank?).and_return(false)
      allow(cell).to receive(:empty?).and_return(true)

      expect { board.reveal(0, 0) }.to change(board, :empty_fields).from(25).to(24)
    end

    it 'returns correct mines stepped count' do
      cell = matrix[0][0]
      allow(cell).to receive(:mine?).and_return(true)
      board.reveal(0, 0)

      expect(board.mines_stepped).to eq(1)
    end
  end

  describe '#revealed_matrix' do
    it 'returns revealed matrix' do
      expect(board.revealed_matrix.flatten).to all(satisfy(&:revealed?))
    end
  end
end
