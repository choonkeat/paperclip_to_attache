class AddAttacheJsonColumns < ActiveRecord::Migration
  def change
    add_column :albums, :cover_art, :json
    add_column :albums, :images, :json
  end
end
