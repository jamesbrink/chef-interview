#
# Cookbook Name:: app_beta
# Recipe:: default
#
# Copyright 2014, Liftopia
#
# All rights reserved - Do Not Redistribute
#
#

package 'ruby1.9.3'
package 'libsasl2-dev'
package 'libmysqlclient-dev'
package 'nodejs'
package 'mongodb'
package 'redis-server'

gem_package 'bundler'

directory '/apps' do
  owner 'vagrant'
  group 'vagrant'
  action :create
  mode 00774
end

deploy_revision '/apps/beta' do
  user 'vagrant'
  group 'vagrant'
  repo 'https://github.com/liftopia/myInterview.git'
  migrate true
  migration_command 'bundle exec rake db:migrate'
  symlinks {}
  before_migrate do
    Dir.chdir(release_path) do
      directory "/apps/beta/shared/config"
      directory "/apps/beta/shared/log"
      directory "/apps/beta/shared/pids"
      cookbook_file "/apps/beta/shared/config/database.yml"
      system('bundle --deployment --path /tmp/bundles')
      system('mysqladmin create my_interview_development || echo "Already Created"')
    end
  end
  before_restart do
    Dir.chdir(release_path) do
      Dir.entries('tmp/pids').each do |pid|
        system("kill -9 `cat tmp/pids/#{pid}`") unless pid =~ /^\.+$/
      end
    end
  end

  restart_command 'bundle exec rackup -p 9293 -D -P ./tmp/pids/rack.pid'
end

user 'liftopian'
