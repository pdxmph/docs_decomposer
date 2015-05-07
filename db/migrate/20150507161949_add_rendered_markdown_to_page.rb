class AddRenderedMarkdownToPage < ActiveRecord::Migration
  def change
    add_column :pages, :rendered_markdown, :text
  end
end
