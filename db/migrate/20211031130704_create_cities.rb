class CreateCities < ActiveRecord::Migration[6.0]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :slug
      t.string :state
      t.text :abstract
      t.integer :population
      t.float :idh
      t.float :max_temp_avg
      t.float :min_temp_avg
      t.float :rain_days
      t.float :daylight_hours
      t.float :bus_cost

      t.timestamps
    end
  end
end
