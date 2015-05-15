class RemoveSourceRepoFromVersion < ActiveRecord::Migration
  def change
    remove_column :versions, :source_repo, :string
  end
end
