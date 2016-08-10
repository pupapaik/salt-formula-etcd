{%- from "etcd/map.jinja" import server with context %}
{%- if server.enabled %}

etcd_packages:
  pkg.installed:
  - names: {{ server.pkgs }}

/etc/default/etcd:
  file.managed:
    - source: salt://etcd/files/default/
    - template: jinja
    - require:
      - pkg: etcd_packages

etcd_service:
  service.running:
  - name: etcd
  - enable: True
  - watch:
    - file: /etc/default/etcd

{%- if pillar.calico is defined %}
#ubuntu 14.04


#fstab
#tmpfs /var/lib/etcd tmpfs nodev,nosuid,noexec,nodiratime,size=512M 0 0
#mount -a

/etc/init/etcd.conf:
  file.managed:
  - source: salt://etcd/files/etcd/calico
  - template: jinja

etcd_service:
  service.running:
  - name: etcd
  - enable: True
  - reload: True

{%- endif %}

{%- endif %}
