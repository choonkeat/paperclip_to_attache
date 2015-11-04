class Image < ActiveRecord::Base
  has_attached_file :file, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/

  before_save :extract_dimensions
  def extract_dimensions
    tempfile = file.queued_for_write[:original]
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(tempfile)
      self.file_dimensions = [geometry.width.to_i, geometry.height.to_i].join('x')
    end
  end
end
