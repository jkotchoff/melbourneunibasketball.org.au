class ContentImage < ActiveRecord::Base
  belongs_to :page
  
  attr_accessible :image
  
  mount_uploader :image, ImageUploader
end