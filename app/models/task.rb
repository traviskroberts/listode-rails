class Task < ActiveRecord::Base
  has_many :lists
  has_many :month_lists, :through => :lists
  belongs_to :user
  belongs_to :task_group
  
  validates_presence_of :title
  
  def self.active
    all(:conditions => "(deleted_at IS NULL OR deleted_at > CURRENT_TIMESTAMP) AND task_group_id IS NULL")
  end
end
