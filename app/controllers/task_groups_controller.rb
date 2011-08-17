class TaskGroupsController < ApplicationController
  before_filter :require_user
  
  def index
    @task_groups = current_user.task_groups.active
  end

  def show
    @task_group = current_user.task_groups.find(params[:id])
  end

  def new
    @task_group = current_user.task_groups.new
  end

  def edit
    @task_group = current_user.task_groups.find(params[:id])
  end

  def create
    # try to find the task group if its been marked as deleted and un-delete it
    if current_user.task_groups.where("title = ?", params[:task_group][:title]).first
      @task_group = current_user.task_groups.where("title = ?", params[:task_group][:title]).first
      @task_group.deleted_at = nil
    else
      @task_group = current_user.task_groups.new(params[:task_group])
    end
    
    if @task_group.save
      redirect_to task_groups_path
    else
      flash[:error] = 'Task group failed to be created'
      render :action => 'new'
    end
  end
  
  def add_task_group
    current_user.task_groups.create(:title => params[:title])
    redirect_to request.env["HTTP_REFERER"] # send them back from where they came
  end

  def update
    @task_group = current_user.task_groups.find(params[:id])
    if @task_group.update_attributes(params[:task_group])
       redirect_to task_groups_path
    else
      flash[:error] = 'There was a problem updating the task.'
      render :action => 'edit'
    end
  end

  def destroy
    @task_group = current_user.task_groups.find(params[:id])
    respond_to do |format|
      if @task_group.update_attributes(:deleted_at => Time.now)
        @js_result = 'success'
        format.html {
          flash[:notice] = 'Task group was successfully deleted.'
          redirect_to task_groups_path
        }
        format.js # destroy.js.erb
      else
        @js_result = 'failure'
        format.html {
          flash[:error] = 'That task group could not be deleted.'
          redirect_to task_groups_path
        }
        format.js # destroy.js.erb
      end
    end
  end
  
end
