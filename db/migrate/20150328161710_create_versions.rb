class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :version_number
      t.references :project, index: true

      t.timestamps null: false
    end
    add_foreign_key :versions, :projects
  end
end
