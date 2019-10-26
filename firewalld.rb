# Cookbook Name:: hardening
# Recipe:: firewalld
#

# Fix for "xccdf_org.cisecurity.benchmarks_rule_4.7_Enable_firewalld"
package 'firewalld'

service 'firewalld' do
  supports status: true
  action [:disable, :stop]
end
