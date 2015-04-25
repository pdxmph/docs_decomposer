class AddBranchToPage < ActiveRecord::Migration
  def change
    add_column :pages, :branch, :string
  end
end
