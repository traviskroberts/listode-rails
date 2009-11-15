class CreateTaskGroups < ActiveRecord::Migration
  def self.up
    create_table :task_groups do |t|
      t.integer   :user_id
      t.string    :title
      t.datetime  :deleted_at
      t.timestamps
    end
    
    add_index :task_groups, :user_id
  end

  def self.down
    drop_table :task_groups
  end
end
