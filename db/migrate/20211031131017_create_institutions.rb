class CreateInstitutions < ActiveRecord::Migration[6.0]
  def change
    create_table :institutions do |t|
      t.string :name
      t.string :initials
      t.string :slug
      t.string :foundation
      t.string :website
      t.string :instagram
      t.integer :total_students
      t.integer :ci
      t.integer :igc
      t.integer :igc_c

      t.timestamps
    end
  end
end
