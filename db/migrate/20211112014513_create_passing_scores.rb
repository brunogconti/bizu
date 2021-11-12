class CreatePassingScores < ActiveRecord::Migration[6.0]
  def change
    create_table :passing_scores do |t|
      t.references :segment, null: false, foreign_key: true
      t.string :name
      t.float :passing_score

      t.timestamps
    end
  end
end
