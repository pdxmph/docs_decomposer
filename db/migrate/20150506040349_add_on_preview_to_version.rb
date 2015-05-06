class AddOnPreviewToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :on_preview, :boolean
  end
end
