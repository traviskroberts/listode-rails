class Task < ActiveRecord::Base
  has_many :lists
  has_many :month_lists, :through => :lists
  belongs_to :user
  belongs_to :task_group
  
  named_scope :active, :conditions => 'deleted_at IS NULL OR deleted_at > NOW()'
  named_scope :ungrouped, :conditions => 'task_group_id IS NULL'
  
  validates_presence_of :title
end
