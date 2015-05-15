class RemoveOnPreviewFromVersion < ActiveRecord::Migration
  def change
    remove_column :versions, :on_preview, :boolean
  end
end
