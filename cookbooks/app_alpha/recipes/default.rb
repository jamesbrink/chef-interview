#
# Cookbook Name:: app_alpha
# Recipe:: default
#
# Copyright 2014, Liftopia
#
# All rights reserved - Do Not Redistribute
#
#

require_recipe 'ruby'
require_recipe 'git'
require_recipe 'nodejs'
require_recipe 'redis'
require_recipe 'mongodb'
require_recipe 'memcached'
require_recipe 'mysql::server'
require_recipe 'supervisor'

# TODO could be put into mysql recipe - mysql::client-dev?
package 'libmysqlclient-dev'
package 'libsasl2-dev'

gem_package 'bundler'

user 'liftopian' do
  comment 'Used to run liftopia applications'
  home '/apps'
  shell '/bin/false'
  system true
end

directory '/apps' do
  owner 'liftopian'
  group 'liftopian'
  action :create
  mode 00775
end

#deploy_revision '/apps/alpha' do
deploy '/apps/alpha' do
  user 'liftopian'
  group 'liftopian'
  repo 'https://github.com/liftopia/myInterview.git'
  migrate true
  migration_command 'bundle exec rake db:migrate'
  symlinks ({"config/unicorn.rb" => "config/unicorn.rb", "config/database.yml" => "config/database.yml"})
  before_migrate do
    Dir.chdir(release_path) do
      directory "/apps/alpha/shared/config"
      directory "/apps/alpha/shared/log"
      directory "/apps/alpha/shared/pids"
      cookbook_file "/apps/alpha/shared/config/database.yml"
      cookbook_file "/apps/alpha/shared/config/unicorn.rb"
      cookbook_file "/etc/supervisor/conf.d/alpha.conf"
      system('bundle --deployment --path /var/tmp/bundles')
      system('mysqladmin create my_interview_development || echo "Already Created"')
    end
  end

  restart_command 'supervisorctl reread && supervisorctl update && supervisorctl restart alpha'
end

