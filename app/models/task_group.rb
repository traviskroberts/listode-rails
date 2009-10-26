class TaskGroup < ActiveRecord::Base
  has_many :tasks
  belongs_to :user
  
  validates_presence_of :title
  
  def self.active
    all(:conditions => "deleted_at IS NULL OR deleted_at > CURRENT_TIMESTAMP")
  end
end
