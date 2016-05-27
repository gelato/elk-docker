# -*- mode: ruby -*-
# vi: set ft=ruby :
ENV["LC_ALL"] = "en_US.UTF-8"
$nodes = 5

Vagrant.configure(2) do |config|

 (1..$nodes).each do |i|
     config.ssh.username = "vagrant"

     config.vm.define "node#{i}" do |node|
         node.vm.box = "ubuntu/trusty64"
         node.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
         node.vm.network :public_network, ip: "192.168.0.#{169+i}",
            :use_dhcp_assigned_default_route => true, bridge: "eth0"
         node.vm.network :private_network, ip: "192.168.111.#{10+i}"
         node.vm.hostname = "node#{i}"
         node.vm.network "forwarded_port", guest: 9200, host: 9200,
            auto_correct: true
         node.vm.network "forwarded_port", guest: 9300, host: 9300,
            auto_correct: true
         node.vm.synced_folder '.', '/vagrant', mount_options: ["dmode=777,fmode=666"]

        node.vm.provider "virtualbox" do |v|
           v.memory = 2048
           v.cpus = 1
       end

           if i == $nodes
               node.vm.provision :ansible do |ansible|
                  #  ansible.verbose = "vvv"
                   ansible.limit = "all"
                   ansible.playbook = "main.yml"
                   ansible.groups = {
                       "main:children" => ["elasticsearch_master", "logstash", "filebeat"],
                       "logstash" => ["node[4:5]"],
                       "filebeat" => ["node[1:5]"],
                       "elasticsearch_master" => ["node[1:3]"],
                       "elasticsearch_master:vars" => {
                           "elasticsearch_publish_host" => "{{ ansible_eth1.ipv4.address }}",
                           "elasticsearch_discovery_zen_ping_unicast_hosts" => "{{ hostvars | fetchlistfromdict(groups.elasticsearch_master) | map(attribute='ansible_eth1.ipv4') | map(attribute='address') | list }}"
                       }
                    }
               end
           end
        end
    end
  config.vm.define "librenms" do |librenms|
    librenms.vm.box = "centos/7"
    librenms.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
    librenms.vm.network :public_network, ip: "192.168.0.111",
       :use_dhcp_assigned_default_route => true, bridge: "eth0"
    librenms.vm.network :private_network, ip: "192.168.111.111"
    librenms.vm.hostname = "librenms"
    librenms.vm.provider "virtualbox" do |v|
       v.memory = 2048
       v.cpus = 1
     end
    librenms.vm.provision :ansible do |ansible|
      #  ansible.verbose = "vvv"
       ansible.limit = "all"
       ansible.playbook = "main.yml"
       ansible.groups = {
           "main" => ["librenms"],
           "main:children" => ["memcached", "apache2"],
           "memcached" => ["librenms"],
           "apache2" => ["librenms"]
         }
    end
  end
end
