cd ../../..
export $(heroku config --shell)
export EMAIL_RECEIVER=pedrozath@gmail.com
unset DATABASE_URL
unset INSCRICOES_ABERTAS
export INSCRICOES_ABERTAS=ON
bundle install
bundle exec rake db:migrate
foreman start -p 3000