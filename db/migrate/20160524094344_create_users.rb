class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :userslug
      t.string :email
      t.string :picture
      t.string :fullname
      t.string :signature
      t.integer :reputation
      t.integer :postcount
      t.boolean :banned
      t.string :status
      t.integer :uid
      t.integer :lastonline

      t.timestamps null: false
    end
  end
end
