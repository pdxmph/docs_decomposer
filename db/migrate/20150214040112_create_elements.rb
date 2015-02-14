class CreateElements < ActiveRecord::Migration
  def change
    create_table :elements do |t|
      t.string :kind
      t.integer :page_id
      t.string :filename
      t.text :content
      t.string :checksum

      t.timestamps null: false
    end
  end
end
