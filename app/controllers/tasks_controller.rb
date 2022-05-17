class TasksController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @tasks = @user.tasks
  end
  
  def show
    @user = User.find(params[:user_id])
    @task = Task.find(params[:id])
  end
  
  def new
    @user = User.find(params[:user_id])
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url(current_user)
    else
      render :new
    end
  end
  
  def edit
    @task = Task.find(params[:id])
    @user = User.find(params[:user_id])
  end
  
  def update
    @task = Task.find(params[:id])
    redirect_to user_task_url(current_user)
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to user_tasks_url
  end
  
  private
  
    def task_params
      params.require(:task).permit(:name, :note)
    end
end

