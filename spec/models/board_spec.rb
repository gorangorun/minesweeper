# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Board, type: :model do
  describe 'validations' do
    # name
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most(20) }

    # email
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to allow_value('test@test.tld').for(:email) }
    it { is_expected.not_to allow_value('test@test').for(:email) }

    # width
    it { is_expected.to validate_presence_of(:width) }
    it { is_expected.to validate_numericality_of(:width).is_greater_than_or_equal_to(2).is_less_than_or_equal_to(100) }

    # height
    it { is_expected.to validate_presence_of(:height) }
    it { is_expected.to validate_numericality_of(:height).is_greater_than_or_equal_to(2).is_less_than_or_equal_to(100) }

    # mines
    it { is_expected.to validate_presence_of(:mines) }
    it { is_expected.to validate_numericality_of(:height).only_integer }
  end

  describe 'callbacks' do
    it 'generates matrix' do
      board = build(:board)
      board.valid?
      expect(board.errors).to be_empty
    end

    it 'fails to generate matrix' do
      board = build(:board)
      board.mines = 1000
      board.valid?
      max_mines = board.width * board.height - 1
      expect(board.errors.full_messages).to include("Mines Max mines: #{max_mines}")
    end
  end
end
