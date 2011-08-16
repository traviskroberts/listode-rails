class TaskGroup < ActiveRecord::Base
  has_many :tasks, :conditions => "deleted_at IS NULL OR deleted_at > NOW()"
  belongs_to :user

  scope :active, where("deleted_at IS NULL OR deleted_at > NOW()")

  validates_presence_of :title
end
