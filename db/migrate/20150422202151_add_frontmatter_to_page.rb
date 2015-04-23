class AddFrontmatterToPage < ActiveRecord::Migration
  def change
    add_column :pages, :frontmatter, :text
  end
end
