class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string  :name
      t.string  :email
      t.date    :member_since
      t.boolean :admin, :default => false
      t.boolean :task_reminder, :default => true
      t.string  :crypted_password
      t.string  :password_salt
      t.string  :persistence_token
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
