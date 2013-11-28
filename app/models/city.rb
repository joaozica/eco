class City < ActiveRecord::Base
  attr_accessible :name
  has_many :company
  belongs_to :state
end