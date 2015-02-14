class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :element_id
      t.boolean :risk
      t.integer :user_id
      t.boolean :flagged

      t.timestamps null: false
    end
  end
end
