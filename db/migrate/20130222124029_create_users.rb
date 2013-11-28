class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :company
      t.string :name
      t.boolean :remember_me
      t.string :role
      t.timestamps
    end
    add_index :users, :company_id
  end
end
