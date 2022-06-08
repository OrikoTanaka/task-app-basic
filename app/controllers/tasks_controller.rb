class TasksController < ApplicationController
  
  before_action :set_user, only: [:index, :show, :new, :edit, :update]
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user, only: :new
  before_action :admin_or_correct_user, only: :update
  before_action :limitation_correct_user, only: :edit
  
  
  def index
    @tasks = @user.tasks.order("id DESC")
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
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
  end
  
  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = "タスクを更新しました。"
      redirect_to user_task_url(current_user, @task)
    else
      render :edit      
    end
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
    
    def set_user
      @user = User.find(params[:user_id])
    end
    
    def limitation_correct_user
      unless @current_user.id == params[:user_id].to_i
        flash[:danger] = "ほかのユーザーの編集はできません。"
        redirect_to root_url
      end
    end
        
end

