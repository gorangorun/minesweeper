# frozen_string_literal: true

module Minesweeper
  class Gameplay
    include Concerns::PrintMatrix

    attr_reader :board, :message
    attr_accessor :display_matrix

    def initialize(board, display_matrix: false)
      @board = board
      @display_matrix = display_matrix
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
      print_matrix if display_matrix
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
