#encoding: UTF-8
class Donor < ActiveRecord::Base

  belongs_to :company
  attr_accessible :birth_date, :document_type, :id
  attr_accessible :legal_identifier, :name, :role, :company_id
  attr_accessible :uses_medication, :uses_medication_description, :gender
  has_many :drug_tests
  # attr_accessible :title, :body
  validates_presence_of :company_id
 

  def self.select_random (company, amount)
  	Donor.where('company_id = ?', company.id).order("RANDOM()").limit(amount)
  end

  
  def self.select_random_by_history (company, amount)
    SelectedTest.joins(:drug_test=> :donor).where('selected_tests.result= ?', :positive).group('donors.id').order("RANDOM()").limit(amount)
  end
  def self.to_csv(options = {})
    require 'csv'
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |donor|
        csv << donor.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    return if file == nil
    require 'csv'
    
    CSV.foreach(file.path, headers: true) do |row|
      donor = find_by_id(row["id"]) || new
      donor.attributes = row.to_hash.slice(*accessible_attributes)
      donor.birth_date = DateTime.parse(row["birth_date"])
      donor.save!
    end
  end
end

