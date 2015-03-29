class RemoveUrlFromPages < ActiveRecord::Migration
  def change
    remove_column :pages, :url, :string
  end
end
