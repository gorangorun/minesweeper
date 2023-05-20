# frozen_string_literal: true

module Minesweeper
  class Board
    include Concerns::PrintMatrix

    EMPTY = 'X'
    MINE = 'M'

    attr_reader :matrix, :width, :height, :mines, :empty_fields, :mines_stepped

    def initialize(matrix:, width:, height:, mines:, debug: false)
      @matrix = matrix
      @width = width
      @height = height
      @mines = mines
      @mines_stepped = count_stepped_mines
      @empty_fields = count_empty_fields
      @debug = debug
    end

    def solved_matrix
      @solved_matrix ||= matrix.map do |row|
        row.map do |element|
          case element
          when BoardFactory::EMPTY
            EMPTY
          when BoardFactory::MINE
            MINE
          else
            element
          end
        end
      end
    end

    # rubocop:disable Naming/MethodParameterName
    def set(x, y)
      case matrix[x][y]
      when BoardFactory::EMPTY
        matrix[x][y] = EMPTY
        @empty_fields -= 1
      when BoardFactory::MINE
        matrix[x][y] = MINE
        @mines_stepped += 1
      end

      print_matrix if @debug
    end
    # rubocop:enable Naming/MethodParameterName

    private

    def count_empty_fields
      matrix.flatten.count(BoardFactory::EMPTY)
    end

    def count_stepped_mines
      matrix.flatten.count(MINE)
    end
  end
end
