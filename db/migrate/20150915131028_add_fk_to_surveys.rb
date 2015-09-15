class AddFkToSurveys < ActiveRecord::Migration
  def change
  	add_column :surveys, :lecture_id, :integer
  	add_foreign_key :surveys, :lectures, column: :lecture_id, primary_key: :id
  end
end
