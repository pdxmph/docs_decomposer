class AddSourceRepoToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :source_repo, :string
  end
end
