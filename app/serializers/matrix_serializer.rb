# frozen_string_literal: true

class MatrixSerializer
  class << self
    def load(matrix)
      return if matrix.nil?

      matrix = YAML.load(matrix)
      matrix.map do |cells|
        cells.map do |cell|
          c = Minesweeper::Cell.new
          c.reveal if %w[M X].include?(cell)
          c.set_mine if ['M', 1].include?(cell)
          c
        end
      end
    end

    def dump(matrix)
      return if matrix.nil?

      res = matrix.map do |cells|
        cells.map do |cell|
          if cell.revealed?
            cell.mine? ? 'M' : 'X'
          else
            cell.mine? ? 1 : 0
          end
        end
      end
      YAML.dump(res)
    end
  end
end
