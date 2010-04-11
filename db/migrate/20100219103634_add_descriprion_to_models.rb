class AddDescriprionToModels < ActiveRecord::Migration
  def self.up
    add_column :models, :description, :text
  end

  def self.down
    remove_column :models, :description
  end
end
