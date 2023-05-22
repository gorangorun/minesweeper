# frozen_string_literal: true

module Minesweeper
  module Concerns
    module PrintMatrix
      # rubocop:disable Rails/Output
      def print_matrix
        matrix.each do |x|
          x.each do |y|
            print y.revealed? ? "[#{y.value}]" : '[x]'
          end
          puts
        end
      end
      # rubocop:enable Rails/Output
    end
  end
end
