class CreateClinics < ActiveRecord::Migration
  def change
    create_table :clinics do |t|
      t.string :name
      t.string :address
      t.references :city
      t.string :address_neighbourhood

      t.timestamps
    end
    add_index :clinics, :city_id
  end
end
