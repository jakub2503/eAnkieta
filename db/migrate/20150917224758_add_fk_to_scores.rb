class AddFkToScores < ActiveRecord::Migration
  def change
  	add_foreign_key :scores, :surveys, column: :survey_id, primary_key: :id
  end
end
