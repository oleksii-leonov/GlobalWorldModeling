class AddYearsToModels < ActiveRecord::Migration
  def self.up
    add_column :models, :year, :integer
  end

  def self.down
    remove_column :models, :year
  end
end
