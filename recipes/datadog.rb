#
# Cookbook Name:: masala_haproxy
# Recipe:: datadog
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

primary_if = node['network']['interfaces'][node['system']['primary_interface']]
primary_addrs = primary_if['addresses']
primary_addrs_ipv4 = primary_addrs.select { |_addr, attrs| attrs['family'] == 'inet' }
primary_ip = primary_addrs_ipv4.keys.first

if node['masala_base']['dd_enable'] and not node['masala_base']['dd_api_key'].nil?
  node.set['datadog']['haproxy']['instances'] = [ {
    :url => "http://localhost:#{node['haproxy']['admin']['port']}",
    :status_check => false,
    :collect_aggregates_only => true,
    :collect_status_metrics => true
    #:username => "username",
    #:password => "secret"
  } ]
  include_recipe 'datadog::haproxy'
end

