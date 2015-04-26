class AddRepoIdToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :repo_id, :integer
  end
end
