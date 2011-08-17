class TasksController < ApplicationController
  before_filter :require_user

  def index
    @task_groups = current_user.task_groups.active
    @unfiled_tasks = current_user.tasks.active.ungrouped
  end

  def show
    @task = current_user.tasks.get(params[:id])
  end

  def new
    @task = current_user.tasks.new
    @task_groups = current_user.task_groups.active.collect { |g| [g.title, g.id] }
  end

  def edit
    @task = current_user.tasks.find(params[:id])
    @task_groups = current_user.task_groups.active.collect { |g| [g.title, g.id] }
  end

  def create
    # try to find the task if its been marked as deleted and un-delete it (don't want them re-creating a deleted task)
    if current_user.tasks.where("title = ?", params[:task][:title]).first
      @task = current_user.tasks.where("title = ?", params[:task][:title]).first
      @task.deleted_at = nil
    else
      @task = current_user.tasks.new(params[:task])
    end

    if @task.save
      # we need to add this task to the current list (if it exists)
      today = Date.today
      cur_list = current_user.month_lists.where("year = ? AND month = ?", today.year, today.month).first
      if !cur_list.nil?
        cur_list.lists << List.new(:task_id => @task.id)
        cur_list.save
      end

      # we need to add this task to the next month's list (if it exists)
      get_next_month_and_year
      next_list = current_user.month_lists.where("year = ? AND month = ?", @next_year, @next_month).first
      if !next_list.nil?
        next_list.lists << List.new(:task_id => @task.id)
        next_list.save
      end

      redirect_to tasks_path
    else
      flash[:error] = 'Task could not be created.'
      render :action => 'new'
    end
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update_attributes(params[:task])
       redirect_to tasks_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    respond_to do |format|
      if @task.update_attributes(:deleted_at => Time.now)
        @js_result = 'success'
        format.html {
          flash[:notice] = 'Task was successfully marked as deleted. This task will still show up on current and previous lists, but will not show up on any future lists."'
          redirect_to tasks_path
        }
        format.js # destroy.js.erb
      else
        @js_result = 'failure'
        format.html {
          flash[:error] = 'That task could not be deleted.'
          redirect_to tasks_path
        }
        format.js # destroy.js.erb
      end
    end
  end

end
