class TestType < ActiveRecord::Base
  attr_accessible :name,:description,:collected_material, :short_name
  validates_presence_of :name
  has_many :selected_test
  has_many :drug_tests, :through => :selected_test
end
