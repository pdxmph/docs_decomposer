class RemovePreviewServerFromVersion < ActiveRecord::Migration
  def change
    remove_column :versions, :preview_server, :string
  end
end
