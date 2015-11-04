class Album < ActiveRecord::Base
  has_attached_file :cover_art, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :cover_art, content_type: /\Aimage\/.*\Z/

  has_many :images
  accepts_nested_attributes_for :images, allow_destroy: true

  before_save :extract_dimensions
  def extract_dimensions
    tempfile = cover_art.queued_for_write[:original]
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(tempfile)
      self.cover_art_dimensions = [geometry.width.to_i, geometry.height.to_i].join('x')
    end
  end
end
