class DrugTest < ActiveRecord::Base
  belongs_to :donor
  belongs_to :selection
  has_many :selected_test
  has_many :test_types,:through => :selected_test
  
  attr_accessible :id, :scheduled_to, :notes
  attr_accessible  :donor_id, :selection_id
 # validates_presence_of :donor_id
 def self.to_csv(options = {})
  CSV.generate(options) do |csv|
    csv << column_names
    all.each do |selection|
      csv << selection.attributes.values_at(*column_names)
    end
  end
end
end
