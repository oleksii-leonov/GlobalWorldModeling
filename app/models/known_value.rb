class KnownValue < ActiveRecord::Base
  has_many :countries, :through => :country_known_values
  has_many :country_known_values
  
  has_many :countries, :through => :model_variable_values
  has_many :model_variable_values
  
  has_and_belongs_to_many :models
  
  validates_presence_of :name, :name_short, :description
  validates_format_of :name_short, :with => /[a-z\_]{3,}/ , :message => "At least 3 symbols length and contain only small latin symbols (or underscore sign)"
  validates_uniqueness_of :name, :name_short

  attr_accessor(:uploadfile)

end
