class AddSourceNameToKnownValues < ActiveRecord::Migration
  def self.up
    add_column :known_values, :source_name, :string
  end

  def self.down
    remove_column :known_values, :source_name
  end
end
