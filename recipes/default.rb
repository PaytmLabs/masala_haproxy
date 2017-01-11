#
# Cookbook Name:: masala_haproxy
# Recipe:: default
#
# Copyright 2016, Paytm Labs
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

node.default['haproxy']['enable_default_http'] = false
node.default['haproxy']['global_options'] = ['quiet']
node.default['haproxy']['admin']['address_bind'] = '0.0.0.0'

include_recipe "masala_base::default"
include_recipe "haproxy::manual"
include_recipe "masala_haproxy::datadog"

logrotate_app 'haproxy' do
  path      '/var/log/haproxy'
  frequency 'daily'
  options   ['missingok', 'delaycompress', 'notifempty']
  rotate    7
  create    "644 #{node.haproxy.user} #{node.haproxy.group}"
end

logrotate_app 'haproxy-warn' do
  path      '/var/log/haproxy-warn'
  frequency 'daily'
  options   ['missingok', 'delaycompress', 'notifempty']
  rotate    7
  create    "644 #{node.haproxy.user} #{node.haproxy.group}"
end

