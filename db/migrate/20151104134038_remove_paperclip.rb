class RemovePaperclip < ActiveRecord::Migration
  def up
    remove_attachment :albums, :cover_art
    remove_column :albums, :cover_art_dimensions

    drop_table :images
  end

  def down
    add_attachment :albums, :cover_art
    add_column :albums, :cover_art_dimensions, :string

    create_table "images" do |t|
      t.integer  "album_id"
      t.datetime "created_at",        null: false
      t.datetime "updated_at",        null: false
      t.string   "file_file_name"
      t.string   "file_content_type"
      t.integer  "file_file_size"
      t.datetime "file_updated_at"
      t.string   "file_dimensions"
    end
  end
end
