class AddVersionIdToPage < ActiveRecord::Migration
  def change
    add_column :pages, :version_id, :integer
  end
end
