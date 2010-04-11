class AddModelIdToModelVariableValues < ActiveRecord::Migration
  def self.up
    add_column :model_variable_values, :model_id, :integer
  end

  def self.down
    remove_column :model_variable_values, :model_id
  end
end
