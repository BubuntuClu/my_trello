require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :request do
  let(:board) { Board.create(title: 'test') }
  let!(:column) { board.columns.create }

  describe('#create') do
    let(:action) do
      ->{ post api_v1_column_tasks_path(column_id: column.id, title: 'test') }
    end

    it 'response success' do
      action.call
      expect(response).to be_successful
    end

    it 'valid json' do
      action.call
      json = JSON.parse(response.body)
      task = Task.last
      expect(json.dig("task_id")).to match task.id
      expect(json.dig("task_title")).to match task.title
    end
  end

  describe('#destroy') do
    let!(:task) { column.tasks.create(title: 'test') }

    let(:action) do
      ->{ delete api_v1_task_path(task.id) }
    end

    it 'response success' do
      action.call
      expect(response).to be_successful
    end

    it 'deletes column' do
      expect { action.call }.to change(Task, :count).by(-1)
    end
  end

  describe('#update') do
    let!(:task) { column.tasks.create(title: 'test') }

    let(:action) do
      ->{ patch api_v1_task_path(task.id, title: 'new') }
    end

    it 'response success' do
      action.call
      expect(response).to be_successful
    end

    it 'updates column' do
      action.call
      task.reload
      expect(task.title).to eq 'new'
    end
  end
end
