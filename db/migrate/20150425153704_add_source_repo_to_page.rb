class AddSourceRepoToPage < ActiveRecord::Migration
  def change
    add_column :pages, :source_repo, :string
  end
end
