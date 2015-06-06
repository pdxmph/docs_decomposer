class AddWebPathToProject < ActiveRecord::Migration
  def change
    add_column :projects, :web_path, :string
  end
end
