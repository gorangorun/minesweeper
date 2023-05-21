# frozen_string_literal: true

module Minesweeper
  class Board
    include Concerns::PrintMatrix

    attr_reader :matrix, :width, :height, :mines, :empty_fields, :mines_stepped

    def initialize(matrix:, width:, height:, mines:)
      @matrix = matrix
      @width = width
      @height = height
      @mines = mines
      @mines_stepped = count_stepped_mines
      @empty_fields = count_empty_fields
    end

    def revealed_matrix
      @revealed_matrix ||= matrix.dup.each do |cells|
        cells.each(&:reveal)
      end
    end

    # rubocop:disable Naming/MethodParameterName
    def set(x, y)
      cell = matrix[x][y]
      return if cell.revealed?

      cell.reveal

      if cell.mine?
        @mines_stepped += 1
      else
        @empty_fields -= 1
      end
    end
    # rubocop:enable Naming/MethodParameterName

    private

    def count_empty_fields
      matrix.flatten.count { |cell| cell.empty? && !cell.revealed? }
    end

    def count_stepped_mines
      matrix.flatten.count { |cell| cell.mine? && cell.revealed? }
    end
  end
end
