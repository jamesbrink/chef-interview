#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2014, Liftopia
#
# All rights reserved - Do Not Redistribute
#
#

package "nginx" do
  action :install
end

service "nginx" do
  action :enable
  action :start
end