class CarrierWave::Uploader::Base
  def asset_path(*args)
    ActionController::Base.helpers.asset_path(*args)
  end
end
