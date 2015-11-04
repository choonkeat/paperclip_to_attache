class PopulatePaperclipDataIntoAttacheJson < ActiveRecord::Migration

  # always define a specific class for the migration
  class Album < ActiveRecord::Base
    def self.to_s; "Album"; end # important

    has_attached_file :cover_art, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :cover_art, content_type: /\Aimage\/.*\Z/
  end

  class Image < ActiveRecord::Base
    def self.to_s; "Image"; end # important

    has_attached_file :file, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/
  end
  # end

  def aws_uri_to_path(uri)
    case uri.host
    when 's3.amazonaws.com'
      URI.decode uri.path.split('/')[2..-1].join('/') # skip over the bucket name in path
    else
      URI.decode uri.path[1..-1]
    end
  end

  def up
    Album.find_each do |album|
      album.update_columns(
        cover_art: {
          path: aws_uri_to_path(URI.parse(album.cover_art.url('original'))),
          content_type: album.cover_art.content_type,
          geometry: album.cover_art_dimensions,
        },
        images: Image.where(album_id: album.id).collect {|image|
          {
            path: aws_uri_to_path(URI.parse(image.file.url('original'))),
            content_type: image.file.content_type,
            geometry: image.file_dimensions,
          }
        },
      )
    end
  end

  def down
    Album.update_all cover_art: nil, images: nil
  end

end
