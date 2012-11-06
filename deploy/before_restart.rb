# -*- encoding : utf-8 -*-
# Restarting Goliath server
sudo "/usr/bin/monit restart #{app}"

# Reconfiguring nginx
run "cp /data/#{app}/current/config/nginx/#{app}.conf /etc/nginx/servers"

