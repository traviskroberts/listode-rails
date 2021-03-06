class MonthList < ActiveRecord::Base
  has_many :lists, :dependent => :destroy
  has_many :tasks, :through => :lists, :dependent => :destroy
  belongs_to :user

  validates_presence_of :month

  MONTHS = {
    1 => 'January',
    2 => 'February',
    3 => 'March',
    4 => 'April',
    5 => 'May',
    6 => 'June',
    7 => 'July',
    8 => 'August',
    9 => 'September',
    10 => 'October',
    11 => 'November',
    12 => 'December'
  }

  def cur_ungrouped_lists
    list_arr = []
    month = self.month > 9 ? self.month : "0#{self.month}"
    date = DateTime.civil(self.year, month.to_i)
    self.ordered_lists.each do |l|
      list_arr << l if ((l.task.deleted_at.blank? or l.task.deleted_at >= date) and l.task.task_group.blank?)
    end
    list_arr
  end

  def cur_grouped_lists
    list_arr = []
    month = self.month > 9 ? self.month : "0#{self.month}"
    date = DateTime.civil(self.year, month.to_i)
    self.ordered_lists.each do |l|
      list_arr << l if ((l.task.deleted_at.blank? or l.task.deleted_at >= date) and !l.task.task_group.blank?)
    end
    list_arr.sort_by do |l|
      complete = l.complete ? 1 : 0
      [l.task.task_group_id, complete, l.task.title]
    end
    # list_arr.sort_by { |l| [l.task.task_group_id, l.complete ? 1 : 0, ] }
  end

  def ordered_lists
    self.lists.all(:order => [:complete])
  end

  def month_name
    MONTHS[self.month][0..2]
  end
end
