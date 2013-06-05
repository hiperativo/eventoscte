# encoding: utf-8

class ClippingImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :fog

  version :thumb do
     resize_to_fill 240, 130
  end

end
