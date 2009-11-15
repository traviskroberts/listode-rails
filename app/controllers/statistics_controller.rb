class StatisticsController < ApplicationController
  before_filter :require_user
  
  def index
    @month_list = current_user.month_lists.first(:order => "year, month")
    @tasks = current_user.tasks.active
  end
  
  def show
    @task = current_user.tasks.find(params[:id])
    
  end
  
end
