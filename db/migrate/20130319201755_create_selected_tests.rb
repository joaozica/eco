class CreateSelectedTests < ActiveRecord::Migration
  def change
    create_table :selected_tests do |t|
      t.references :drug_test
      t.references :test_type
      t.string :result
      t.datetime :completed_at

      t.timestamps
    end
    add_index :selected_tests, :drug_test_id
    add_index :selected_tests, :test_type_id
  end
end
