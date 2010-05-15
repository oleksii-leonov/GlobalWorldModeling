class AddUserToModelAndVariables < ActiveRecord::Migration
  def self.up
    add_column :models, :user_id, :integer
    add_column :known_values, :user_id, :integer
    
    add_index :countries, :name, :unique => true 
  end

  def self.down
    remove_column :models, :user_id, :integer
    remove_column :known_values, :user_id, :integer
    
    remove_index :countries, :name
  end
end
