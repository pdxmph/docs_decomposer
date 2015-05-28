class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.integer :priority
      t.string :work
      t.string :frequency
      t.string :state

      t.timestamps null: false
    end
  end
end
