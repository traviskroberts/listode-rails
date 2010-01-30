class StatisticsController < ApplicationController
  before_filter :require_user
  
  def index
    @all_lists = current_user.month_lists.all(:order => 'year, month')
    @month_list = @all_lists.first
    @tasks = current_user.tasks.active
  end
  
  def show
    @task = current_user.tasks.find(params[:id])
  end
  
end
