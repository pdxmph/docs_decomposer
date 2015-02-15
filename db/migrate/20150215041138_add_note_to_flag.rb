class AddNoteToFlag < ActiveRecord::Migration
  def change
    add_column :flags, :note, :text
  end
end
