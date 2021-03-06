class TaskGroup < ActiveRecord::Base
  has_many :tasks, :dependent => :destroy
  belongs_to :user

  scope :active, where("deleted_at IS NULL OR deleted_at > NOW()")

  validates_presence_of :title
end
