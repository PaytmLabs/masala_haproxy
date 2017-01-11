
default['masala_haproxy']['keepalive_password'] = 'abc123'

# the default check script for haproxy
default['keepalived']['check_scripts']['chk_haproxy']['script'] = 'killall -0 haproxy'
default['keepalived']['check_scripts']['chk_haproxy']['interval'] = 2
default['keepalived']['check_scripts']['chk_haproxy']['weight'] = 2

default['rsyslog']['default_facility_logs']['local0.*'] = '/var/log/haproxy'
default['rsyslog']['default_facility_logs']['local1.warn'] = '/var/log/haproxy-warn'

