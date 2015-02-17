class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :content
      t.integer :page_id
      t.integer :element_id

      t.timestamps null: false
    end
  end
end
