# Cookbook Name:: hardening
# Recipe:: at_daemon
#
# Addresses xccdf_org.cisecurity.benchmarks_rule_6.1.10_Restrict_at_Daemon
case node['platform_family']
when 'rhel'
  if node['platform_version'].to_f >= 7.0

    file '/etc/at.deny' do
      action :delete
    end

    file '/etc/at.allow' do
      action :create
      mode 0700
      owner 'root'
      group 'root'
    end

  end
end
# End xccdf_org.cisecurity.benchmarks_rule_6.1.10_Restrict_at_Daemon
