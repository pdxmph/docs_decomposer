class AddLiveUrlToPage < ActiveRecord::Migration
  def change
    add_column :pages, :live_url, :string
  end
end
