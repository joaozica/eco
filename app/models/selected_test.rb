class SelectedTest < ActiveRecord::Base
  belongs_to :drug_test
  belongs_to :test_type
  attr_accessible :result,:completed_at
  
  
end
