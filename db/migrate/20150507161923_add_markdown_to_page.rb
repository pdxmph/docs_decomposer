class AddMarkdownToPage < ActiveRecord::Migration
  def change
    add_column :pages, :markdown, :text
  end
end
