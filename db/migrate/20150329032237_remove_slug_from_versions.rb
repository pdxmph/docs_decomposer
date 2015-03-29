class RemoveSlugFromVersions < ActiveRecord::Migration
  def change
    remove_column :versions, :slug, :string
  end
end
