#
# Cookbook:: dfhg-base-linux
# Recipe:: package_manager
#
 
case node['platform_family']
when 'rhel'
  yum_repository '*-Base' do
    description '* - Base'
    baseurl 'https://******/base'
    proxy '_none_'
    gpgcheck false
    action :create
  end
  yum_repository '*-Updates' do
    description '* - Updates'
    baseurl 'https://*******/updates'
    proxy '_none_'
    gpgcheck false
    action :create
  end
  yum_repository '*-Extras' do
    description '* - Extras'
    baseurl 'https://*******/extras'
    proxy '_none_'
    gpgcheck false
    action :create
  end
 
  repos = ['CentOS-Base','CentOS-CR','CentOS-Debuginfo','CentOS-fasttrack','CentOS-Media','CentOS-Sources','CentOS-Vault']
  repos.each do |i|
    yum_repository i do
      enabled false
    end
