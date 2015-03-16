class AddNearestHeadingToElements < ActiveRecord::Migration
  def change
    add_column :elements, :nearest_heading, :string
  end
end
