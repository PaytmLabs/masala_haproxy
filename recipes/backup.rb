#
# Cookbook Name:: masala_haproxy
# Recipe:: backup
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

include_recipe "masala_haproxy::default"

node.default['masala_keepalived']['name'] = node['system']['short_hostname']
node.default['masala_keepalived']['state'] = 'BACKUP'
node.default['masala_keepalived']['priority'] = 100
node.default['masala_keepalived']['advert_int'] = 1
node.default['masala_keepalived']['nopreempt'] = false
node.default['masala_keepalived']['auth_type'] = 'PASS'
node.default['masala_keepalived']['auth_pass'] = node['masala_haproxy']['keepalive_password']

node.default['masala_keepalived']['vi_1'] = node['masala_haproxy']['keepalive_vi_1']
node.default['masala_keepalived']['vi_1']['track_script'] = 'chk_haproxy'

# add second instance vi_2 config if specced, same as above for vi_1
if ! node['masala_haproxy']['keepalive_vi_2'].nil?
  node.default['masala_keepalived']['vi_2'] = node['masala_haproxy']['keepalive_vi_2']
  node.default['masala_keepalived']['vi_2']['track_script'] = 'chk_haproxy'
end

include_recipe "masala_keepalived::default"

