class CreateGerritOwners < ActiveRecord::Migration
  def change
    create_table :gerrit_owners do |t|
      t.integer :account_id
      t.string :name
      t.string :email

      t.timestamps null: false
    end
  end
end
