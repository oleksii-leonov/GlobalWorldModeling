class Model < ActiveRecord::Base
has_many :known_values, :through => :model_variable_values
has_many :model_variable_values

has_and_belongs_to_many :countries, :order => 'name ASC'
has_and_belongs_to_many :known_values, :order => 'name ASC'

validates_presence_of :name, :formula, :year
validates_numericality_of :year, :greater_than => 2009, :less_than => 2201
validates_uniqueness_of :name
end
