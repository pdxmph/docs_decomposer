class AddSshCloneUrlToRepo < ActiveRecord::Migration
  def change
    add_column :repos, :ssh_clone_url, :string
  end
end
