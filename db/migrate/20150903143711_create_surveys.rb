class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :token, :null => false, :limit => 4
      t.timestamp :start_date, :null => false
      t.timestamp :end_date, :null => false

      t.timestamps null: false
    end
  end
end
