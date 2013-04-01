CarrierWave.configure do |config|
	config.fog_credentials = {
		:provider                         => 'Google',
		:google_storage_access_key_id     => ENV['CLOUD_ID'],
		:google_storage_secret_access_key => ENV['CLOUD_SECRET']
	}
	config.fog_directory = 'eventoscte'
end