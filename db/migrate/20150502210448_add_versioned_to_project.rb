class AddVersionedToProject < ActiveRecord::Migration
  def change
    add_column :projects, :versioned, :boolean
  end
end
