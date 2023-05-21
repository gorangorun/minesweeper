# frozen_string_literal: true

module Minesweeper
  class Cell
    attr_reader :mine, :revealed

    def initialize
      @mine = false
      @revealed = false
    end

    def mine?
      @mine
    end

    def empty?
      !mine?
    end

    def revealed?
      @revealed
    end

    def reveal
      @revealed = true
    end

    def set_mine
      @mine = true
    end
  end
end
