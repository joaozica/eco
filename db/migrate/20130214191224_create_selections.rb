class CreateSelections < ActiveRecord::Migration
  def change
    create_table :selections do |t|
      t.string :name
      t.string :criteria
      t.string :exame_responsible
      t.string :selection_responsible

      t.timestamps
    end
  end
end
