# frozen_string_literal: true

class Board < ApplicationRecord
  EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  serialize :matrix, MatrixSerializer

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :email, presence: true, format: { with: EMAIL_FORMAT }
  validates :width, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than_or_equal_to: 100 }
  validates :height, presence: true,
                     numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than_or_equal_to: 100 }
  validates :mines, presence: true, numericality: { only_integer: true }

  after_validation :generate_matrix, on: :create

  scope :by_recent, -> { order(id: :desc) }

  def board(service = Minesweeper::Board)
    @board ||= service.new(matrix:, width:, height:, mines:)
  end

  private

  def generate_matrix
    self.matrix = Minesweeper::BoardFactory.new(width:, height:, mines:).produce.matrix unless errors.any?
  rescue Minesweeper::BoardFactory::MaxMinesError, Minesweeper::BoardFactory::MinMinesError => e
    errors.add(:mines, e.message)
  end
end
