# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
     resize_to_fill 108, 96
  end

  version :medium do
     resize_to_fill 208, 132
  end

  version :big do
     resize_to_fill 1008, 456
  end

end
