Cookbook:: dfhg-base-linux
# Recipe:: openview
#
 
case node['chef_environment']
when 'prod', 'chef-test'
  package 'm4' do
    action :install
  end
 
  package 'unzip' do
    action :install
  end
 
  ruby_block "Ensure node can resolve OV server" do
    block do
      fe = Chef::Util::FileEdit.new("/etc/hosts")
      fe.insert_line_if_no_match('* * * * *.com','* * *.10   * * *.com')
      fe.write_file
    end
    not_if { Resolv.getaddress('* * * * com') rescue false }
  end
 
  bash 'Install openview' do
    code <<-EOH
      mkdir /tmp/OV
      curl -o /tmp/OV/ovagent.zip http://* * * */ovagent/ovagent.zip
      unzip /tmp/OV/ovagent.zip
      chmod 777 -R ./ovagent
      ./ovagent/oainstall.sh -i -a -includeupdates -minprecheck -s * * * *.com -cs * * * *.com
      rm -rf ./ovagent
      EOH
    not_if { ::File.exist?('/opt/OV/bin/ovc') }
  end
 
  bash 'Start OVCtrl service' do
    code <<-EOH
      /opt/OV/bin/opcagt -kill
      /opt/OV/bin/ovc -kill
      /opt/OV/bin/ovc -start
      EOH
    not_if '/etc/init.d/OVCtrl status'
  end
 
end
