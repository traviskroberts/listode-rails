class Feedback < ActionMailer::Base

  def feedback(fields={})
    fields.keys.each do |k|
      instance_variable_set("@#{k}", fields[k])
    end

    mail :from => fields[:email], :to => FEEDBACK_EMAIL, :subject => '[listode.com] Feedback from user'
  end
end
