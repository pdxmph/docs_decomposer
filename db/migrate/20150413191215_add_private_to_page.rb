class AddPrivateToPage < ActiveRecord::Migration
  def change
    add_column :pages, :private, :boolean
  end
end
