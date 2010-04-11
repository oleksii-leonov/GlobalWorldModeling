class AddVariablesChartToModels < ActiveRecord::Migration
  def self.up
    add_column :models, :variables_chart, :string
  end

  def self.down
    remove_column :models, :variables_chart
  end
end
