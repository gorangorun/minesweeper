# frozen_string_literal: true

module Minesweeper
  module Concerns
    module PrintMatrix
      def print_matrix
        matrix.each do |x|
          x.each do |y|
            Rails.logger.debug "[#{y}]"
          end
          Rails.logger.debug "\n"
        end
      end
    end
  end
end
