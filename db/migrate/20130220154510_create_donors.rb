class CreateDonors < ActiveRecord::Migration
  def change
    create_table :donors do |t|
      t.string :name
      t.string :legal_identifier
      t.string :document_type
      t.datetime :birth_date
      t.string :role
      t.references :company
      t.string :gender
      t.boolean :uses_medication
      t.string :uses_medication_description
      t.timestamps
    end
    add_index :donors, :company_id
  end
end
