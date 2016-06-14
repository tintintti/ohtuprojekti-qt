class CreateGerritCodeReviews < ActiveRecord::Migration
  def change
    create_table :gerrit_code_reviews do |t|
      t.string :change_id_from_gerrit
      t.integer :gerrit_change_id
      t.integer :gerrit_owner_id
      t.integer :value

      t.timestamps null: false
    end
  end
end
