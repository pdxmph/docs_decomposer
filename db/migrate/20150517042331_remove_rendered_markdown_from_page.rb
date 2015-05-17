class RemoveRenderedMarkdownFromPage < ActiveRecord::Migration
  def change
    remove_column :pages, :rendered_markdown, :text
  end
end
