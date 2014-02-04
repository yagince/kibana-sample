# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "opscode-centos65"
  config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.5_chef-provisionerless.box"
  config.omnibus.chef_version = :latest

  config.vm.define :kibana_test_web do |web|
    web.vm.network :forwarded_port, guest: 80, host: 8081
    web.vm.network :private_network, ip: "192.168.0.10", virtualbox__intnet: "intnet"
    web.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
    end
    web.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = ["./chef/cookbooks/","./chef/site-cookbooks/"]
      chef.add_recipe "nginx"
      chef.add_recipe "td-agent::kibana_test"
      chef.json = {
        nginx: {
          version: "1.4.1",
          install_method: "source",
          source: {
            version: "1.4.1",
            modules: ["nginx::http_echo_module"]
          },
          init_style: "init",
          worker_processes: 1,
          echo: {
            version: '0.48'
          },
          log: "ltsv",
          echo_sleep: [1,3,5]
        },
        td_agent: {
          api_key: 'kibana_test_web',
          base_conf_template: "td-agent-web.conf.erb"
        }
      }
    end
  end

  config.vm.define :kibana_test_log do |log|
    log.vm.network :forwarded_port, guest: 80, host: 8082
    log.vm.network :private_network, ip: "192.168.0.11", virtualbox__intnet: "intnet"
    log.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
    end
    log.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = ["./chef/cookbooks/","./chef/site-cookbooks/"]
      chef.add_recipe "nginx"
      chef.add_recipe "java"
      chef.add_recipe "elasticsearch"
      chef.add_recipe "kibana"
      chef.add_recipe "td-agent::kibana_test"
      chef.json = {
        nginx: {
          version: "1.4.1",
          install_method: "source",
          source: {
            version: "1.4.1",
          },
          init_style: "init",
          worker_processes: 1,
          log: "",
          echo_sleep: [],
          kibana: {
            root: "/opt/kibana/current/src"
          }
        },
        td_agent: {
          api_key: 'kibana_test_log',
          base_conf_template: "td-agent-log.conf.erb",
          plugins: ['elasticsearch']
        },
        java: {
          install_flavor: "openjdk",
          jdk_version: "7"
        },
        elasticsearch: {
          cluster: {
            name: "elasticsearch_test_chef"
          },
          "bootstrap.mlockall" => false
        },
        kibana: {
          webserver: "",
          user: "nginx"
        }
      }
    end
  end

end
