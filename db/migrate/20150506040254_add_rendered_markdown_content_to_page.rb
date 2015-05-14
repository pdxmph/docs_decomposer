class AddRenderedMarkdownContentToPage < ActiveRecord::Migration
  def change
    add_column :pages, :rendered_markdown_content, :text
  end
end
