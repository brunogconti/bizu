class CreateSegments < ActiveRecord::Migration[6.0]
  def change
    create_table :segments do |t|
      t.references :course, null: false, foreign_key: true
      t.string :sisu_edition

      t.timestamps
    end
  end
end
