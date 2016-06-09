class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.integer :repository_id
      t.integer :author_id
      t.string :sha
      t.integer :stamp

      t.timestamps null: false
    end
  end
end
