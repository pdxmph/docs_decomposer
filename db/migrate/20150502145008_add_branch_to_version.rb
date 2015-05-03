class AddBranchToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :branch, :string
  end
end
