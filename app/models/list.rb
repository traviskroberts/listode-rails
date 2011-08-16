class List < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  belongs_to :task
  belongs_to :month_list

  def amount_and_notes
    output = "<div id=\"list_notes_#{self.id}\">"
    if !amount.blank? and !notes.blank?
      output << "<p class=\"list_details\">Paid #{number_to_currency(amount)}<br />#{notes.gsub("\n",'<br />')}</p>"
    elsif !amount.blank?
      output << "<p class=\"list_details\">Paid #{number_to_currency(amount)}</p>"
    elsif !notes.blank?
      output << "<p class=\"list_details\">#{notes.gsub('\n','<br />')}</p>"
    end
    output << "</div>"
    output
  end
end
