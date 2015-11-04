class Album < ActiveRecord::Base
  has_one_attache :cover_art
  has_many_attaches :images
end
