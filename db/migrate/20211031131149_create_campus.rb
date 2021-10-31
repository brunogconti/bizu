class CreateCampus < ActiveRecord::Migration[6.0]
  def change
    create_table :campus do |t|
      t.references :citie, null: false, foreign_key: true
      t.references :institution, null: false, foreign_key: true
      t.string :name
      t.string :address
      t.string :website

      t.timestamps
    end
  end
end
