bash 'monthly update' do
  code <<-EOH
    echo '0 22 28 * * /usr/bin/yum update -y' >> /var/spool/cron/root
    EOH
End
