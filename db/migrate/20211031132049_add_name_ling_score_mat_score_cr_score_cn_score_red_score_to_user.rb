class AddNameLingScoreMatScoreCrScoreCnScoreRedScoreToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :ling_score, :float
    add_column :users, :mat_score, :float
    add_column :users, :cr_score, :float
    add_column :users, :cn_score, :float
    add_column :users, :red_score, :float
  end
end
