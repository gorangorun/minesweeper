# frozen_string_literal: true

module Minesweeper
  class Gameplay
    include Concerns::PrintMatrix

    attr_reader :board, :message

    def initialize(board)
      @board = board
      set_message
    end

    def ended?
      lost? || won?
    end

    def won?
      board.empty_fields.zero?
    end

    def lost?
      board.mines_stepped.positive?
    end

    def play(...)
      board.set(...)

      set_message
    end

    delegate :matrix, to: :board

    private

    def set_message
      @message = if won?
                   'You won'
                 elsif lost?
                   'You lost'
                 else
                   "Fields left: #{board.empty_fields}"
                 end
    end
  end
end
