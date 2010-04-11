class CreateModelVariableValues < ActiveRecord::Migration
  def self.up
    create_table :model_variable_values do |t|
      t.integer :known_value_id
      t.integer :country_id
      t.float :value
      t.integer :year
    end
  end

  def self.down
    drop_table :model_variable_values
  end
end
