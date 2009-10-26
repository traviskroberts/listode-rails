class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.integer   :user_id
      t.integer   :task_group_id
      t.string    :title
      t.datetime  :deleted_at
      t.timestamps
    end
    
    add_index :tasks, :user_id
    add_index :tasks, :task_group_id
  end

  def self.down
    drop_table :tasks
  end
end
