class RemovePrivateFromVersion < ActiveRecord::Migration
  def change
    remove_column :versions, :private, :boolean
  end
end
