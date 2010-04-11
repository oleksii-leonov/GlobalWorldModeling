class CountryKnownValue < ActiveRecord::Base
  belongs_to :countries
  belongs_to :known_values
end
