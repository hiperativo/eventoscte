# encoding: utf-8

class EventCoverUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
     resize_to_fill 490, 180
  end

  version :big do
     resize_to_fill 744, 192
  end

end
