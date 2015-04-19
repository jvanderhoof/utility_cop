# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"

  config.vm.network :forwarded_port, guest: 3000, host: 3030
  config.vm.network :private_network, ip: "10.10.10.10"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end

  config.vm.synced_folder "./", "/home/vagrant/app", type: 'nfs'

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.

=begin
  # Install Postgres 9.3
  config.vm.provision "shell", inline: <<-SHELL
    echo 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main' >> /etc/apt/sources.list.d/pgdg.list
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    sudo apt-get update -qq && sudo apt-get upgrade -y
    sudo apt-get install -y postgresql-9.3
  SHELL

  config.vm.provision "file", source: "vagrant_config/pg_hba.conf", destination: "/tmp/pg_hba.conf"

  config.vm.provision "shell", inline: <<-SHELL
    sudo cp /tmp/pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf
    sudo chown postgres:postgres /etc/postgresql/9.3/main/pg_hba.conf
    sudo /etc/init.d/postgresql restart
    rm /tmp/pg_hba.conf
  SHELL
=end
  # Install Ruby 2.2.0
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update -qq
    sudo apt-get install -y git-core curl build-essential bison openssl libreadline6 libreadline6-dev zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev autoconf libc6-dev ssl-cert subversion libffi-dev wget libpq-dev
    wget -P /tmp/ http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p645.tar.gz
    cd /tmp && tar -zxvf ruby-2.0.0-p645.tar.gz
    cd /tmp/ruby-2.0.0-p645 && ./configure && make && sudo make install
    rm /tmp/ruby-2.0.0-p645.tar.gz && rm -rf /tmp/ruby-2.0.0-p645
  SHELL
=begin
   # Install Redis
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get install -y build-essential tcl
    wget -P /tmp/ http://download.redis.io/releases/redis-2.8.19.tar.gz
    cd /tmp && tar -zxvf redis*
    cd /tmp/redis* && make && sudo make install
    cd /tmp/redis* && echo -n | sudo utils/install_server.sh
    rm -rf /tmp/redis*
  SHELL

  config.vm.provision "shell", inline: 'gem install bundler nokogiri foreman --no-rdoc --no-ri'
  config.vm.provision "shell", inline: 'echo "cd /home/vagrant/app" >> /home/vagrant/.bashrc'
=end
end
