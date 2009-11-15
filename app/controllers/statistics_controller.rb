class StatisticsController < ApplicationController
  before_filter :require_user
  
  def index
    @tasks = current_user.tasks.active
  end
  
  def show
    @task = current_user.tasks.find(params[:id])
    
  end
  
end
