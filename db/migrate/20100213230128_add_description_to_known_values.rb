class AddDescriptionToKnownValues < ActiveRecord::Migration
  def self.up
    add_column :known_values, :description, :text
  end

  def self.down
    remove_column :known_values, :description
  end
end
