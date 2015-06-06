class AddPublishedToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :published, :boolean
  end
end
