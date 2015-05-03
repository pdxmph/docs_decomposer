class AddPrivateToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :private, :boolean
  end
end
