class AddPreviewServerToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :preview_server, :string
  end
end
