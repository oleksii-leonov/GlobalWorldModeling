class CreateModelsCountries < ActiveRecord::Migration
  def self.up
    create_table :countries_models, :id => false do |t|
      t.integer :model_id
      t.integer :country_id
    end
    add_index :countries_models, [:model_id, :country_id], :unique => true
    add_index :countries_models, :model_id, :unique => false
  end

  def self.down
    drop_table :countries_models
  end
end
