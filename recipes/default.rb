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

# common keepalive defaults

node.default['masala_keepalived']['name'] = node['system']['short_hostname']
node.default['masala_keepalived']['advert_int'] = 1
node.default['masala_keepalived']['nopreempt'] = false
node.default['masala_keepalived']['auth_type'] = 'PASS'
node.default['masala_keepalived']['auth_pass'] = node['masala_haproxy']['keepalive_password']

["vi_1", "vi_2", "vi_3"].each do |vi|
  if ! node['masala_haproxy']["keepalive_#{vi}"].nil?
    node.default['masala_keepalived'][vi] = node['masala_haproxy']["keepalive_#{vi}"]
    node.default['masala_keepalived'][vi]['track_script'] = 'chk_haproxy'
  else
    if vi == "vi_1"
      raise "keepalive_vi_1 must exist in configuration"
    end
  end
end

# haproxy defaults
node.default['haproxy']['enable_default_http'] = false
node.default['haproxy']['global_options'] = {
  'quiet' => ''
}
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

