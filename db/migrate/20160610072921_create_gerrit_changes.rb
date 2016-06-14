class CreateGerritChanges < ActiveRecord::Migration
  def change
    create_table :gerrit_changes do |t|
      t.string :kind
      t.string :id_from_gerrit
      t.string :project
      t.string :branch
      t.string :change_id
      t.string :subject
      t.string :status
      t.string :created
      t.string :updated
      t.boolean :mergeable
      t.string :sortkey
      t.integer :number
      t.integer :gerrit_owner_id

      t.timestamps null: false
    end
  end
end
