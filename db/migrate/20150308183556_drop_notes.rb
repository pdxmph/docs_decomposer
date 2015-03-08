class DropNotes < ActiveRecord::Migration

  def up
    drop_table :notes
  end

  def down
    create_table :notes do |t|
      t.integer :page_id
      t.integer :element_id
      t.text :content
      t.timestamps
    end
    
  end
end
