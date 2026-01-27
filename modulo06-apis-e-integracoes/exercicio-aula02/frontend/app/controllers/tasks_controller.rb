class TasksController < ApplicationController
  def index
    raw_data = Api::Tasks.get_index(fields: %w[id title description deadline])
    @tasks = raw_data["data"]["tasks"].map{ |t| Task.new(task_payload: t) }
  end

  def create
    @task = Api::Tasks.create_task(input_hash: task_params["task"], return_fields: ['id'])
    
    if @task["errors"]
      redirect_to tasks_url, alert: @task["errors"].map{|e| e["message"]}.join("\n")
    else
      redirect_to tasks_url
    end
  end

  def edit
    raw_data = Api::Tasks.get_index(fields: %w[id title description deadline])
    tasks = raw_data["data"]["tasks"].map{ |t| Task.new(task_payload: t) }
    @task = tasks.detect{ |t| t.id == params[:id] }
  end

  def update
    @task = Api::Tasks.update_task(input_hash: task_params, return_fields: ['id'])

    if @task["errors"]
      redirect_to tasks_url, alert: @task["errors"].map{|e| e["message"]}.join("\n")
    else
      redirect_to tasks_url
    end
  end

  def destroy
    @task = Api::Tasks.destroy_task(id: task_params["id"])

    if @task["errors"]
      redirect_to tasks_url, alert: @task["errors"].map{|e| e["message"]}.join("\n")
    else
      redirect_to tasks_url
    end
  end

  private

  def task_params
    params.permit(:id, task: [:title, :description, :deadline])
  end
end
