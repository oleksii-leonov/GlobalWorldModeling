class CreateKnownValuesModels < ActiveRecord::Migration
  def self.up
    create_table :known_values_models, :id => false do |t|
      t.integer :model_id
      t.integer :known_value_id
    end
    add_index :known_values_models, [:model_id, :known_value_id], :unique => true
    add_index :known_values_models, :model_id, :unique => false
  end

  def self.down
    drop_table :known_values_models
  end
end