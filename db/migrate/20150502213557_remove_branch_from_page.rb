class RemoveBranchFromPage < ActiveRecord::Migration
  def change
    remove_column :pages, :branch, :string
  end
end
