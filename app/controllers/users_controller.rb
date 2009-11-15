class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  before_filter :require_admin, :only => [:list, :tasks]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account created!"
      redirect_back_or_default root_path
    else
      render :action => :new
    end
  end
 
  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to root_path
    else
      render :action => :edit
    end
  end
  
  def list
    @users = User.all
  end
  
  def tasks
    @user = User.find(params[:id])
    @tasks = @user.tasks.active
  end
end
