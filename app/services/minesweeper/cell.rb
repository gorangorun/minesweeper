# frozen_string_literal: true

module Minesweeper
  class Cell
    class MineCellError < StandardError; end

    attr_reader :revealed
    attr_accessor :value

    def initialize
      @revealed = false
      @value = 0
    end

    def increment!
      raise MineCellError, 'Cell contains mine and it\'s value cannot be incremented' if mine?

      @value += 1
    end

    def mine?
      @value == 9
    end

    def empty?
      !mine?
    end

    def blank?
      @value.zero?
    end

    def revealed?
      @revealed
    end

    def reveal
      @revealed = true
    end

    def set_mine
      @value = 9
    end
  end
end
