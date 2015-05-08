class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fist_name
      t.string :last_name
      t.string :email

      t.timestamps null: false
    end
  end
end
