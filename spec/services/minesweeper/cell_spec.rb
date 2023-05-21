# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Minesweeper::Cell, type: :service do
  let(:cell) { described_class.new }

  describe '#mine?' do
    it 'returns false if cell doesnt contain mine' do
      expect(cell.mine?).to eq(false)
    end

    it 'returns true if cell contains mine' do
      cell.set_mine
      expect(cell.mine?).to eq(true)
    end
  end

  describe '#empty?' do
    it 'returns true if cell doesnt contain mine' do
      expect(cell.empty?).to eq(true)
    end

    it 'returns false if cell contains mine' do
      cell.set_mine
      expect(cell.empty?).to eq(false)
    end
  end

  describe '#revealed?' do
    it 'returns true if cell is revealed' do
      cell.instance_variable_set(:@revealed, true)
      expect(cell.revealed?).to eq(true)
    end

    it 'returns false if cell is not revealed' do
      expect(cell.revealed?).to eq(false)
    end
  end

  describe '#reveal' do
    it 'reveals a cell' do
      expect { cell.reveal }.to change(cell, :revealed).from(false).to(true)
    end
  end

  describe '#set_mine' do
    it 'sets a mine' do
      expect { cell.set_mine }.to change(cell, :mine).from(false).to(true)
    end
  end
end
