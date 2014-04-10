#
# Cookbook Name:: supervisor
# Recipe:: default
#
# Copyright 2014, Liftopia
#
# All rights reserved - Do Not Redistribute
#
#


user 'liftopian' do
  comment 'Used to run liftopia applications'
  home '/apps'
  shell '/bin/false'
  system true
end

directory "/etc/supervisor" do
  action :create
  owner "root"
  group "root"
end

template "/etc/supervisor/supervisord.conf" do
  source "supervisord.erb"
  mode 0644
  owner "root"
  group "root"
  variables({
                :supervisor_user => node[:authorization][:supervisor][:user],
                :supervisor_group => node[:authorization][:supervisor][:group]
            })
end

package 'supervisor' do
  action :install
  options "-o Dpkg::Options::=--force-confdef"
end


