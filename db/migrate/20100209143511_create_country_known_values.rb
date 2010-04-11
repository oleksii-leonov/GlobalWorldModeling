class CreateCountryKnownValues < ActiveRecord::Migration
  def self.up
    create_table :country_known_values do |t|
      t.integer :country_id
      t.integer :known_value_id
      t.float :value
      t.integer :year
    end
    
    add_index :country_known_values, [:country_id, :known_value_id, :year], :unique => true,
      :name => 'mybigindex'
    add_index :country_known_values, [:country_id, :known_value_id], :unique => false,
        :name => 'mysmallindex'
    add_index :country_known_values, :country_id, :unique => false
    add_index :country_known_values, :known_value_id, :unique => false

  end

  def self.down
    drop_table :country_known_values
  end
end
