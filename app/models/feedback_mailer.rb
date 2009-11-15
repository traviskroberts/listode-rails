class FeedbackMailer < ActionMailer::Base
  def feedback(fields={})
    @recipients  = FEEDBACK_EMAIL
    @from        = fields[:email]
    @subject     = '[listode.com] Feedback from user'
    @sent_on     = Time.now
    fields.keys.each { |key| @body[key] = fields[key] }
  end
end
