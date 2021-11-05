class AddAttributesToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_type, :string
    add_column :users, :name, :string
    add_column :users, :address, :string
    add_column :users, :course, :string
    add_column :users, :unit, :string
    add_column :users, :institution, :string
    add_column :users, :ling_score, :float
    add_column :users, :mat_score, :float
    add_column :users, :cr_score, :float
    add_column :users, :cn_score, :float
    add_column :users, :red_score, :float
  end
end
