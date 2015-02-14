class AddVersionToPage < ActiveRecord::Migration
  def change
    add_column :pages, :version, :string
  end
end
