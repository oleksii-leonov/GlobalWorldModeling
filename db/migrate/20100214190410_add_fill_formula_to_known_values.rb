class AddFillFormulaToKnownValues < ActiveRecord::Migration
  def self.up
    add_column :known_values, :fill_formula, :text
  end

  def self.down
    remove_column :known_values, :fill_formula
  end
end
