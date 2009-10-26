class CreateMonthLists < ActiveRecord::Migration
  def self.up
    create_table :month_lists do |t|
      t.integer :user_id
      t.integer :month
      t.integer :year
      t.timestamps
    end
  end

  def self.down
    drop_table :month_lists
  end
end
