class RemoveProjectFromPages < ActiveRecord::Migration
  def change
    remove_column :pages, :project, :string
  end
end
