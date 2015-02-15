class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.integer :element_id
      t.integer :user_id
      t.boolean :flagged
      t.integer :page_id

      t.timestamps null: false
    end
  end
end
