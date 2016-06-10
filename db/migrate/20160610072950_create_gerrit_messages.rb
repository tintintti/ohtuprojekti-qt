class CreateGerritMessages < ActiveRecord::Migration
  def change
    create_table :gerrit_messages do |t|
      t.string :message_id
      t.string :date
      t.string :message
      t.integer :revision_number
      t.integer :gerrit_owner_id
      t.integer :gerrit_change_id

      t.timestamps null: false
    end
  end
end
