class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string :name
      t.string :uri
      t.string :branch

      t.timestamps null: false
    end
  end
end
