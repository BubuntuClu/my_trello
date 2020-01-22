class BoardsController < ApplicationController

  def index
    @boards = Board.all
  end

  def show
    @board = Board.find_by(title: params[:title])
  end

  def create
    begin
      board = Board.new(title: SecureRandom.hex[0, 8])

      break if board.save
    end while true

    redirect_to board_path(board.title)
  end

end
