class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :id_survey
      t.integer :general_score
      t.integer :tempo_score
      t.integer :importance_score
      t.string :comment

      t.timestamps null: false
    end
  end
end
