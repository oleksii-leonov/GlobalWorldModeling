require 'active_record/fixtures'

class LoadCountriesData < ActiveRecord::Migration
  def self.up
    
    down
    
    directory = File.dirname(__FILE__)
    directory << "/dev_data"

    Fixtures.create_fixtures(directory, "countries")
  end

  def self.down
    Country.delete_all
  end
end
