# Kibana3 + Fluentd + Elasticsearch

## Initialize

```
$ bundle install --path vendor/bundle
$ bundle exec berks --path chef/cookbooks
$ vagrant plugin install vagrant-vbguest
$ vagrant plugin install vagrant-omnibus
```

## Start VMs & Provisioning

```
$ vagrant up
$ vagrant provision
```

## Send Test Request

```
$ curl -v http://localhost:8081/sleep1
$ curl -v http://localhost:8081/sleep3
$ curl -v http://localhost:8081/sleep5
```

## VMs

### kibana_test_web

- nginx + echo_module
- Fluentd

### kibana_test_log

- ElasticSearch
- Kibana3 + nginx
- Fluentd
