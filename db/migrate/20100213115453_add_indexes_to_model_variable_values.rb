class AddIndexesToModelVariableValues < ActiveRecord::Migration
  def self.up
    add_index :model_variable_values, [:model_id, :known_value_id, :country_id, :year], :unique => true,
      :name => 'my_bigindex'
    add_index :model_variable_values, [:model_id, :known_value_id, :year], :unique => false,
        :name => 'my_sum_bigindex'
    add_index :model_variable_values, :model_id, :unique => false
  end

  def self.down
  end
end
