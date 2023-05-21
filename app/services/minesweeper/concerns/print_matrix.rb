# frozen_string_literal: true

module Minesweeper
  module Concerns
    module PrintMatrix
      # rubocop:disable Rails/Output
      def print_matrix
        matrix.each do |x|
          x.each do |y|
            print "[#{y}]"
          end
          puts
        end
      end
      # rubocop:enable Rails/Output
    end
  end
end
