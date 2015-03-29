class RemoveVersionFromPages < ActiveRecord::Migration
  def change
    remove_column :pages, :version, :string
  end
end
