require 'active_record/fixtures'

class LoadKnownValuesData < ActiveRecord::Migration
  def self.up
    
    down
    
    directory = File.dirname(__FILE__)
    directory << "/dev_data"
    
    Fixtures.create_fixtures(directory, "known_values")
  end

  def self.down
    KnownValue.delete_all
  end
end
