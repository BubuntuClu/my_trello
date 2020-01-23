require 'rails_helper'

RSpec.describe Api::V1::ColumnsController, type: :request do
  let!(:board) { Board.create(title: 'test') }

  describe('#create') do
    let(:action) do
      ->{ post api_v1_columns_path, params: { board_title: board.title} }
    end

    it 'response success' do
      action.call
      expect(response).to be_successful
    end

    it 'valid json' do
      action.call
      json = JSON.parse(response.body)
      column_id = Column.last.id
      expect(json.dig("column_id")).to match column_id
    end
  end

  describe('#destroy') do
    let!(:column) { board.columns.create }

    let(:action) do
      ->{ delete api_v1_column_path(column.id) }
    end

    it 'response success' do
      action.call
      expect(response).to be_successful
    end

    it 'deletes column' do
      expect { action.call }.to change(Column, :count).by(-1)
    end
  end
end
