class ModelVariableValue < ActiveRecord::Base
  belongs_to :countries
  belongs_to :models
  belongs_to :known_values
end
