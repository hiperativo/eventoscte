heroku pgbackups:capture
curl $(heroku pgbackups:url) > remote_db
pg_restore -c -O -d eventoscte -h localhost -v remote_db
rm remote_db