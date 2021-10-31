class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.references :campu, null: false, foreign_key: true
      t.date :opening_date
      t.string :name
      t.string :degree
      t.string :modality
      t.string :shift
      t.integer :total_vacancies
      t.integer :semesters
      t.integer :hours

      t.timestamps
    end
  end
end
