class Task < ActiveRecord::Base
  has_many :lists, :dependent => :destroy
  has_many :month_lists, :through => :lists, :dependent => :destroy
  belongs_to :user
  belongs_to :task_group

  scope :active, where('deleted_at IS NULL OR deleted_at > NOW()')
  scope :ungrouped, where('task_group_id IS NULL')

  validates_presence_of :title
end
