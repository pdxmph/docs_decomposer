class AddActiveToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :active, :boolean
  end
end
