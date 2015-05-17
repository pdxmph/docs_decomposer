class RemoveRepoIdFromVersion < ActiveRecord::Migration
  def change
    remove_column :versions, :repo_id, :integer
  end
end
