class ListsController < ApplicationController
  before_filter :require_user
  
  def index
    redirect_to lists_path
  end
  
  def complete_task
    @list = List.find(params[:id])
    # check to make sure it belongs to the right user
    if !@list.blank? and @list.task.user == current_user
      @list.update_attributes(:complete => true, :amount => sanitize_amount(params[:amount]), :notes => params[:notes])
      # hack to fix 0 amount in database if amount is blank
      @list.update_attributes(:amount => nil) if params[:amount].blank?
    else
      flash[:error] = "You don't have permssion to change that."
    end
    redirect_to request.env["HTTP_REFERER"] # send them back
  end
  
  def uncomplete_task
    @list = List.find(params[:id])
    # check to make sure it belongs to the right user
    if !@list.blank? and @list.task.user == current_user
      @list.update_attributes(:complete => false, :amount => nil, :notes => nil)
    else
      flash[:error] = "You don't have permission to change that."
    end
    redirect_to request.env["HTTP_REFERER"] # send them back
  end
  
  def edit
    @list = List.find(params[:id])
    respond_to do |format|
      format.html {
        session[:edit_link] = request.env['HTTP_REFERER']
      }
      format.js
    end
  end

  def update
    @list = List.find(params[:id])
    if !@list.blank? and @list.task.user == current_user
      params[:list][:amount] = sanitize_amount(params[:list][:amount])
      if @list.update_attributes(params[:list])
        # hack to fix 0 amount in database if amount is blank
        @list.update_attributes(:amount => nil) if params[:list][:amount].blank?
      else
        flash[:error] = 'The list item could not be updated.'
      end
    else
      flash[:error] = "You don't have permission to update that list item."
    end
    
    # return them to the correct page
    if session[:edit_link]
      target = session[:edit_link].dup
      session[:edit_link] = nil
      redirect_to target
    else
      redirect_to request.env["HTTP_REFERER"]
    end
  end
  
  def cancel_edit
    @list = List.find(params[:id])
    respond_to do |format|
      format.html { redirect_to lists_path }
      format.js
    end
  end
  
end
