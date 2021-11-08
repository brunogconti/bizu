class CreateUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :units do |t|
      t.references :citie, null: false, foreign_key: true
      t.references :institution, null: false, foreign_key: true
      t.string :name
      t.string :slug
      t.string :slug_uni
      t.string :address
      t.text :abstract
      t.boolean :internet
      t.boolean :restaurant
      t.boolean :accomodation
      t.boolean :transport
      t.boolean :sports_playground
      t.float :xerox_cost
      t.float :snack_plus_drink_price
      t.float :coffe_price

      t.timestamps
    end
  end
end
