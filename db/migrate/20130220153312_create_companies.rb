class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :legal_identifier
      t.string :legal_name
      t.string :trade_name
      t.string :contact_email
      t.string :contact_phone
      t.string :contact_name
      t.string :address
      t.references :city
      t.string :address_neighbourhood

      t.timestamps
    end
    add_index :companies, :city_id
  end
end
