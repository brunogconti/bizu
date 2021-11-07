class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.references :unit, null: false, foreign_key: true
      t.string :opening_date
      t.string :name
      t.text :abstract
      t.string :degree
      t.string :shift
      t.string :periodization
      t.integer :periodization_num
      t.integer :vacancies
      t.integer :hours
      t.string :website
      t.string :instagram
      t.integer :enade
      t.integer :cpc
      t.integer :cc
      t.integer :idd
      t.float :weight_lin
      t.float :weight_mat
      t.float :weight_ch
      t.float :weight_cn
      t.float :weight_red
      t.float :min_lin
      t.float :min_mat
      t.float :min_ch
      t.float :min_cn
      t.float :min_red
      t.float :min_geral
      t.float :bonus
      t.string :bonus_comment
      t.integer :api_id

      t.timestamps
    end
  end
end
