# frozen_string_literal: true

module Minesweeper
  class BoardFactory
    include Concerns::PrintMatrix

    EMPTY = 0
    MINE = 1

    class MinWidthError < StandardError; end
    class MinHeightError < StandardError; end
    class MinMinesError < StandardError; end
    class MaxMinesError < StandardError; end

    def self.produce(...)
      new(...).produce
    end

    attr_reader :matrix, :width, :height, :mines

    def initialize(width: 5, height: 5, mines: 5)
      @width = width.to_i
      @height = height.to_i
      @mines = mines.to_i
      raise MinWidthError, 'Min width: 2' if @width < 2
      raise MinHeightError, 'Min height: 2' if @height < 2
      raise MinMinesError, 'Min mines: 1' if @mines < 1
      raise MaxMinesError, "Max mines: #{max_mines}" if @mines > max_mines

      @matrix = []
    end

    def produce
      blank_matrix
      place_mines
      Board.new(matrix:, width:, height:, mines:)
    end

    def max_mines
      @max_mines ||= width * height - 1
    end

    private

    def place_mines
      mines.times.each do
        insert_mine
      end
    end

    def insert_mine
      x = rand(width)
      y = rand(height)

      if matrix[y][x].empty?
        matrix[y][x].set_mine
      else
        insert_mine
      end
    end

    def blank_matrix
      height.times.each do |y|
        matrix[y] = []
        width.times.each do |x|
          matrix[y][x] = Cell.new
        end
      end
    end

    def blank_matrix_v2
      @matrix = Array.new(height) { Array.new(width, Cell.new) }
    end

    def blank_matrix_v3
      height.times do
        y = []
        width.times do
          y << Cell.new
        end

        matrix << y
      end
    end
  end
end
