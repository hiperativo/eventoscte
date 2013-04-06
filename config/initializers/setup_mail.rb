ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
	:address              => "smtp.nomedarosa.com.br",
	:port                 => 587,
	:domain               => ENV['EMAIL_DOMAIN'],
	:user_name            => "#{ENV['EMAIL_LOGIN']}@#{ENV['EMAIL_DOMAIN']}",
	:password             => ENV["EMAIL_PASS"],
	:authentication       => :plain,
	:enable_starttls_auto => true
}