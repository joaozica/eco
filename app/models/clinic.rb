class Clinic < ActiveRecord::Base
  belongs_to :city
  attr_accessible :address, :id, :name,:city_id, :address_neighbourhood
  validates_presence_of :city_id
end
