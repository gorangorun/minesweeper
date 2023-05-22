# frozen_string_literal: true

module Boards
  class GameplaysController < ApplicationController
    def update
      @board = Board.find(params[:id])
      @gameplay = Minesweeper::Gameplay.new(@board.board)
      @gameplay.reveal(params[:x].to_i, params[:y].to_i)
      @board.update(matrix: @gameplay.matrix)

      render partial: 'boards/partials/gameplay', board: @board
    end
  end
end
