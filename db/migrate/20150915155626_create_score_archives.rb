class CreateScoreArchives < ActiveRecord::Migration
  def change
    create_table :score_archives do |t|
      t.integer  :lecture_id
      t.decimal :general_score, precision: 3, scale: 2
      t.decimal :tempo_score, precision: 3, scale: 2
      t.decimal :importance_score
      t.integer :number_of_votes

      t.timestamps null: false


    end
	add_index :score_archives, :lecture_id
	add_foreign_key :score_archives, :lectures, column: :lecture_id, primary_key: :id

  end
end
