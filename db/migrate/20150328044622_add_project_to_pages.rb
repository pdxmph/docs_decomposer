class AddProjectToPages < ActiveRecord::Migration
  def change
    add_column :pages, :project, :string
  end
end
