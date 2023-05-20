# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Minesweeper::Gameplay, type: :service do
  let(:board_class) do
    Class.new(Minesweeper::Board) do
      # rubocop:disable Lint/MissingSuper
      def initialize(...) end
      # rubocop:enable Lint/MissingSuper
      def set(...) end
    end
  end

  let(:board) { board_class.new }
  let(:gameplay) { described_class.new(board) }

  describe '#play' do
    it 'sets won message' do
      allow(board).to receive(:empty_fields).and_return(0)
      gameplay.play(1, 0)

      expect(gameplay.message).to eq('You won')
    end

    it 'sets lost message' do
      allow(board).to receive(:empty_fields).and_return(10)
      allow(board).to receive(:mines_stepped).and_return(1)
      gameplay.play(1, 0)

      expect(gameplay.message).to eq('You lost')
    end

    it 'sets fields left message' do
      allow(board).to receive(:empty_fields).and_return(10)
      allow(board).to receive(:mines_stepped).and_return(0)
      gameplay.play(1, 0)

      expect(gameplay.message).to eq('Fields left: 10')
    end
  end
end
