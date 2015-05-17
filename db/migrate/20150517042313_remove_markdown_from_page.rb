class RemoveMarkdownFromPage < ActiveRecord::Migration
  def change
    remove_column :pages, :markdown, :text
  end
end
