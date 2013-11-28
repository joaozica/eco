class CreateDrugTests < ActiveRecord::Migration
  def change
    create_table :drug_tests do |t|
      t.datetime :scheduled_to
      t.references :donor
      t.references :selection
      t.string :notes

      t.timestamps
    end
    add_index :drug_tests, :donor_id
    add_index :drug_tests, :selection_id
  end
end