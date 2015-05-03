class RemovePrivateFromPage < ActiveRecord::Migration
  def change
    remove_column :pages, :private, :boolean
  end
end
