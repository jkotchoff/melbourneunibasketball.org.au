class NewsletterUploader < CarrierWave::Uploader::Base
  include ::CarrierWave::Backgrounder::Delay

  if Rails.env.production? or Rails.env.staging?
    include Cloudinary::CarrierWave
  else
    storage :file
  end

  def filename
    "#{model.created_at.to_s(:newsletter_timestamp)}_volume_#{model.volume_number}_issue_#{"%03d" % model.edition_number}.pdf"
  end

  def store_dir
    "dribbling_balls"
  end
end
