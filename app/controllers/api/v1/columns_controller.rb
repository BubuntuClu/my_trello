class Api::V1::ColumnsController < ApplicationController
  def create
    board = Board.find_by(title: params[:board_title])
    @column = board.columns.create

    json_response
  end

  def destroy
    @column = Column.find(params[:id])
    @column.destroy

    json_response
  end

  private

  def json_response
    render json: { column_id: @column.id }
  end
end
