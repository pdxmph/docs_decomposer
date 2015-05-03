class RemoveSourceRepoFromPage < ActiveRecord::Migration
  def change
    remove_column :pages, :source_repo, :string
  end
end
