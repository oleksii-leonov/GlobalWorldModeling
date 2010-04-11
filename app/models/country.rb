class Country < ActiveRecord::Base
  has_many :known_values, :through => :country_known_values, :order => 'name ASC'
  has_many :country_known_values
  has_many :model_variable_values
  
  has_and_belongs_to_many :models
  
  validates_presence_of :name, :name_ammap
  validates_uniqueness_of :name, :name_ammap
  
end
