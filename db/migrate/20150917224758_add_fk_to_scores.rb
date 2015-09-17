class AddFkToScores < ActiveRecord::Migration
  def change
  	rename_column :scores, :id_survey, :survey_id
  	add_foreign_key :scores, :surveys, column: :id_survey, primary_key: :id
  end
end
