class AddPaperclip < ActiveRecord::Migration
  def up
    add_attachment :albums, :cover_art
    add_attachment :images, :file
  end

  def down
    remove_attachment :albums, :cover_art
    remove_attachment :images, :file
  end
end
