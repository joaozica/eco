class Company < ActiveRecord::Base
  belongs_to :city
  attr_accessible :address, :contact_email, :contact_name, :contact_phone, :id
  attr_accessible  :legal_identifier, :legal_name, :trade_name, :city_id,:address_neighbourhood
  validates_presence_of  :city_id
end
