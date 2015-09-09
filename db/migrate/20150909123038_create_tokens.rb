class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :token, :null => false, :limit => 4

      t.timestamps null: false
    end
  end
end
