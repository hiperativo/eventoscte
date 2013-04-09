# encoding: utf-8

class InterviewPhotoUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :interna do
     resize_to_fill 240, 240
  end

  version :banner do
     resize_to_fill 204, 130
  end

end
