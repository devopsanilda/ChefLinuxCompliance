replace_or_add 'Disable selinux' do
  path '/etc/selinux/config'
  pattern '^SELINUX='
  line 'SELINUX=disabled'
end
 
execute 'execute setenforce 0 if selinux is not disabled' do
  command 'setenforce 0'
  not_if 'getenforce | grep Disabled'
