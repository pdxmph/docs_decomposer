class AddVersionDirectoryToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :version_directory, :string
  end
end
