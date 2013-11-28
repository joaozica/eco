class State < ActiveRecord::Base
  attr_accessible :name, :symbol
  has_many :cities
end