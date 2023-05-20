# frozen_string_literal: true

class BoardsController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @boards = pagy(Board.by_recent, items: 10)
  end

  def new
    @board = Board.new
    @boards = Board.by_recent.limit(10)
  end

  def show
    @board = Board.find(params[:id])
    @gameplay = Minesweeper::Gameplay.new(@board.board)
  end

  def create
    @board = Board.create(board_params)

    @location = board_url(@board) if @board.persisted?

    respond_to do |format|
      format.js
    end
  end

  private

  def board_params
    params.require(:board).permit(:name, :email, :width, :height, :mines)
  end
end
