class AddSlugToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :slug, :string
    add_index :versions, :slug, unique: true
  end
end
