class CreateLists < ActiveRecord::Migration
  def self.up
    create_table :lists do |t|
      t.integer :task_id
      t.integer :month_list_id
      t.boolean :complete, :default => false
      t.float   :amount
      t.text    :notes
      t.timestamps
    end
    
    add_index :lists, :task_id
    add_index :lists, :month_list_id
  end

  def self.down
    drop_table :lists
  end
end
