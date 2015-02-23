class DropFlags < ActiveRecord::Migration

  def up
    drop_table :flags
  end

  def down
    create_table :flags do |t|
      t.integer :element_id
      t.integer :user_id
      t.boolean :flagged
      t.integer :page_id

      t.timestamps null: false
    end

  end
end
