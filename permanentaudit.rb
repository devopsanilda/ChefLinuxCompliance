# Cookbook Name:: cis-el7-l1-hardening
# Recipe:: auditlog-permanent
execute 'auditlog-permanent' do
  command 'echo "max_log_file_action = keep_logs" >> /etc/audit/auditd.conf'
  not_if 'grep "max_log_file_action = keep_logs" /etc/audit/auditd.conf'
end
