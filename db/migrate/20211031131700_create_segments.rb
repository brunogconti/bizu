class CreateSegments < ActiveRecord::Migration[6.0]
  def change
    create_table :segments do |t|
      t.references :course, null: false, foreign_key: true
      t.string :name
      t.string :sisu_edition
      t.float :score
      t.integer :vacancies

      t.timestamps
    end
  end
end
