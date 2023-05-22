# frozen_string_literal: true

module Minesweeper
  class Board
    include Concerns::AdjascentCells
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
    def reveal(x, y)
      cell = matrix[y][x]
      return if cell.revealed?

      @empty_fields -= 1
      cell.reveal
      if cell.mine?
        @mines_stepped += 1
      elsif cell.blank?
        adjascent_cells(y, x).each do |cell_y, cell_x|
          adjascent_cell = matrix[cell_y][cell_x]
          reveal(cell_x, cell_y) if adjascent_cell.empty?
        end
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
