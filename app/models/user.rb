class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :tasks
  has_many :task_groups
  has_many :month_lists
  
  validates_presence_of :name, :email
  validates_uniqueness_of :email
  
  before_create :set_member_since
  
  def member_since_date
    member_since.strftime("%B %d, %Y")
  end
  
  private
    def set_member_since
      self.member_since = Date.today
    end
end
