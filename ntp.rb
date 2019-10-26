# Cookbook Name:: hardening
# Recipe:: ntp
# Remediation for ntp specific controls
#
# Start fix for xccdf_org.cisecurity.benchmarks_rule_6.5_Configure_Network_Time_Protocol_NTP

# Install Package NTP (also installs ntpd)
case node['platform_family']
when 'rhel'
  if node['platform_version'].to_f >= 7.0
    package 'ntp' do
      action :install
    end

    # Create file ntp.conf if not present
    file '/etc/ntp.conf' do
      mode '0644'
      owner 'root'
    end

    # Create file ntpd if not present
    file '/etc/sysconfig/ntpd' do
      mode '0644'
      owner 'root'
    end

    # Correct ntpd config to conform to:
    # /^\s*OPTIONS="[^"]*-u ntp:ntp[^"]*"\s*(?:#.*)?$/
    replace_or_add 'ntpd' do
      path '/etc/sysconfig/ntpd'
      pattern 'OPTIONS='
      line 'OPTIONS="-u ntp:ntp -p /var/run/ntpd.pid -g"'
    end

    service 'ntpd' do
      supports :status => true, :restart => true
    end

    template '/etc/ntp.conf' do
      source 'ntp.conf.erb'
      notifies :restart, 'service[ntpd]', :immediately
    end
  end
end

# End fix for xccdf_org.cisecurity.benchmarks_rule_6.5_Configure_Network_Time_Protocol_NTP
