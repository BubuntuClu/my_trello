class Api::V1::TasksController < ApplicationController
  before_action :find_task, only: [:update, :destroy]

  def create
    column = Column.find(params[:column_id])
    task = column.tasks.create(task_params)

    render json: { column_id: column.id, task_id: task.id, task_title: task.title  }
  end

  def update
    @task.update(task_params)

    json_response
  end

  def destroy
    @task.destroy

    json_response
  end

  private

  def json_response
    render json: { task_id: @task.id, task_title: @task.title  }
  end

  def task_params
    params.permit(:title)
  end

  def find_task
    @task = Task.find(params[:id])
  end
end
