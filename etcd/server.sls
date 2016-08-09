{%- from "etcd/map.jinja" import server with context %}
{%- if server.enabled %}

etcd_packages:
  pkg.installed:
  - names: {{ server.pkgs }}

etcd_config:
  file.managed:
  - name: {{ server.config }}
  - source: salt://etc/default/etcd.conf
  - template: jinja
  - require:
    - pkg: etcd_packages

{%- endif %}
