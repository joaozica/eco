class Selection < ActiveRecord::Base
	has_many :tests
  attr_accessible :name, :criteria, :exame_responsible, :selection_responsible,:completed_at
  validates_presence_of :name
  def self.create_with_random_employees(selection_responsible,name,criteria, company, test_types, type, amount,scheduled_to, donors)
  	selection = Selection.new
  	selection.name = name
    selection.criteria = criteria
    selection.selection_responsible = selection_responsible
  	selection.save
  	
    if type == "B" 
      selected_tests = Donor.select_random_by_history(company, amount)
      selected_tests.each do |selected_test|
        drug_test = DrugTest.new
        drug_test.test_types = test_types
        drug_test.donor = Donor.find_by_id(selected_test.drug_test.donor_id)
        drug_test.selection = selection
        drug_test.scheduled_to=scheduled_to
        drug_test.save
      end
    elsif type == "R"
    	donors = Donor.select_random(company, amount)
      donors.each do |donor|
        drug_test = DrugTest.new
        drug_test.donor = donor
        drug_test.test_types = test_types
        drug_test.selection = selection
        drug_test.scheduled_to=scheduled_to
        drug_test.save
      end
    elsif type == "M"
      donors = donors
        donors.each do |donor|
          drug_test = DrugTest.new
          drug_test.donor = donor
          drug_test.test_types = test_types
          drug_test.selection = selection
          drug_test.scheduled_to=scheduled_to
          drug_test.save
        end
    end
    
  	return selection
  end
end
