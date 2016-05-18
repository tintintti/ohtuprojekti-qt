class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :tid
      t.string :raw_json

      t.timestamps null: false
    end
  end
end
