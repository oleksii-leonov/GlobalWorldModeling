class AddVariablesMapToModels < ActiveRecord::Migration
  def self.up
    add_column :models, :variables_map, :string
  end

  def self.down
    remove_column :models, :variables_map
  end
end
