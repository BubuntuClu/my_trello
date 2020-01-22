class Api::V1::ColumnsController < ApplicationController
  def create
    board = Board.find_by(title: params[:board_title])
    column = board.columns.create

    render json: { column_id: column.id }
  end

  def destroy
    column = Column.find(params[:id])
    column.destroy
    render json: { column_id: column.id }
  end
end
