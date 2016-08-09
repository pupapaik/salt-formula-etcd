{%- from "etcd/map.jinja" import server with context %}
{%- if server.enabled %}

etcd_pkg:
  pkg.installed:
  - name: etcd

etcd_config:
  file.managed:
  - name: {{ server.config }}
  - source: salt://etc/default/etcd.conf
  - template: jinja
  - require:
    - pkg: etcd_packages

etcd_service:
  service.running:
  - name: etcd
  - enable: True
  - watch:
    - file: /etc/default/etcd

{%- endif %}