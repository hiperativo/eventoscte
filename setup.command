cd `dirname $0`
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
gem install foreman
echo "Pronto! Está instalado!"