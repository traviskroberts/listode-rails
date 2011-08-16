class SiteController < ApplicationController
  def index
    redirect_to lists_path and return if current_user
  end

  def feedback
    if request.post?
      if params[:feedback][:name].blank? or params[:feedback][:email].blank? or params[:feedback][:message].blank?
        flash.now[:error] = 'You must fill in all fields.'
      else
        Feedback.feedback(params[:feedback]).deliver
        params[:feedback] = ''
        flash.now[:success] = 'Your email has been sent. Thanks for the feedback!'
      end and return
    end
    params[:feedback] = ''
  end
end
