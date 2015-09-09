class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.string :name
      t.integer :year
      t.string :semester
      t.integer :id_user

      t.timestamps null: false
    end
  end
end
