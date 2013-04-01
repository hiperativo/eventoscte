# encoding: utf-8

class SliderUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :fog

  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :big do
     resize_to_fill 1008, 300
  end

end
