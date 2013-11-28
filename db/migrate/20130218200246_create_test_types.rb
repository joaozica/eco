class CreateTestTypes < ActiveRecord::Migration
  def change
    create_table :test_types do |t|
      t.string :name
      t.string :short_name
      t.string :description
      t.string :collected_material

      t.timestamps
    end
  end
end
