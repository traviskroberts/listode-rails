class SiteController < ApplicationController
  def index
    redirect_to lists_path and return if current_user
    flash.now[:notice] = "Listode is back! Unfortunately, due to a server crash a few weeks ago, all data has been lost. I'm very sorry about that, but please create a new account and re-add your tasks. (A backup process has been implemented, so data should be safe going forward.)"
  end
  
  def feedback
    if request.post?
      if params[:feedback][:name].blank? or params[:feedback][:email].blank? or params[:feedback][:message].blank?
        flash.now[:error] = 'You must fill in all fields.'
      else
        FeedbackMailer.deliver_feedback(params[:feedback])
        params[:feedback] = ''
        flash.now[:success] = 'Your email has been sent. Thanks for the feedback!'
      end and return
    end
    params[:feedback] = ''
  end
end
