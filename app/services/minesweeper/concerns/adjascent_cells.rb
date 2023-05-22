# frozen_string_literal: true

module Minesweeper
  module Concerns
    module AdjascentCells
      private

      # rubocop:disable Naming/MethodParameterName
      def adjascent_cells_without_boundaries(y, x)
        [
          [y - 1, x],
          [y - 1, x + 1],
          [y, x + 1],
          [y + 1, x + 1],
          [y + 1, x],
          [y + 1, x - 1],
          [y, x - 1],
          [y - 1, x - 1]
        ]
      end

      def adjascent_cells(y, x)
        adjascent_cells_without_boundaries(y, x).select do |cell_y, cell_x|
          cell_x.between?(0, width - 1) && cell_y.between?(0, height - 1)
        end
      end
      # rubocop:enable Naming/MethodParameterName
    end
  end
end
