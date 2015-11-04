class AddPaperclipDimenions < ActiveRecord::Migration
  def change
    add_column :albums, :cover_art_dimensions, :string
    add_column :images, :file_dimensions, :string
  end
end
