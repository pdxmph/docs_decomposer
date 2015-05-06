class AddMarkdownContentToPage < ActiveRecord::Migration
  def change
    add_column :pages, :markdown_content, :text
  end
end
