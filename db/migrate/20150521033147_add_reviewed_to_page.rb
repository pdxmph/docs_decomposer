class AddReviewedToPage < ActiveRecord::Migration
  def change
    add_column :pages, :reviewed, :boolean, :default => false
  end
end
