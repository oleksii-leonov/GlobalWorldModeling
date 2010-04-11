class AddUnitMeasurementToKnownValues < ActiveRecord::Migration
  def self.up
    add_column :known_values, :unit_measurement, :string
  end

  def self.down
    remove_column :known_values, :unit_measurement
  end
end
