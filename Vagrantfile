# -*- mode: ruby -*-
# vi: set ft=ruby :
ENV["LC_ALL"] = "en_US.UTF-8"
$nodes = 4

Vagrant.configure(2) do |config|

 (1..$nodes).each do |i|
     config.ssh.username = "vagrant"

     config.vm.define "node#{i}" do |node|
         node.vm.box = "ubuntu/trusty64"
         node.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
         node.vm.network :public_network, ip: "192.168.0.#{230+i}",
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
                   ansible.limit = "all"
                   ansible.playbook = "main.yml"
                   ansible.groups = {
                       "main:children" => ["elasticsearch_master", "logstash"],
                       "logstash" => ["node[1:4]"],
                       "elasticsearch_master" => ["node[1:3]"],
                       "elasticsearch_master:vars" => {
                           "elasticsearch_publish_host" => "{{ ansible_eth1.ipv4.address }}"
                       }
                    }
               end
           end
        end
    end
end
