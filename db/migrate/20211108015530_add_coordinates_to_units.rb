class AddCoordinatesToUnits < ActiveRecord::Migration[6.0]
  def change
    add_column :units, :latitude, :float
    add_column :units, :longitude, :float
  end
end
