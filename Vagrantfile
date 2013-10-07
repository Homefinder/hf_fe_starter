Vagrant.configure("1") do |config|
  config.vm.box       = 'precise32'
  config.vm.box_url   = 'http://files.vagrantup.com/precise32.box'
  config.vm.host_name = 'tech-recruiting-dev-box'

  config.vm.forward_port 3000, 3000
  config.vm.forward_port 5000, 5000
  config.vm.forward_port 5432, 5432

  config.vm.provision :puppet,
    :manifests_path => 'puppet/manifests',
    :module_path    => 'puppet/modules'
end

Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end
end
