class CreateKnownValues < ActiveRecord::Migration
  def self.up
    create_table :known_values do |t|
      t.string :name
      t.string :name_short
    end
  end

  def self.down
    drop_table :known_values
  end
end
