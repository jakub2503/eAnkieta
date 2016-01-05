class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :index
      t.string :password_hash
      t.string :password_salt
      t.string :elogin_info

      t.timestamps null: false
    end
  end
end
