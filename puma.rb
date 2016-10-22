app_path = '/var/www/proconist.net/current'
shared_path = '/var/www/proconist.net/shared'

directory dir
environment ENV['RAILS_ENV']

workers 2

daemonize true
pidfile "#{shared_path}/tmp/pids/puma.pid"
state_path "#{shared_path}/tmp/pids/puma.state"
bind 'unix:///var/run/puma.sock'

stdout_redirect = "#{shared_path}/log/puma.log"
