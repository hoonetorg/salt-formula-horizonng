# -*- coding: utf-8 -*-
# vim: ft=sls

{%- from "horizon/map.jinja" import server with context %}

include:
- horizon.packages

horizon_local_settings:
  file.managed:
  - name: {{ server.local_settings }}
  - source: salt://horizon/files/local_settings/local_settings.{{ server.version }}
  - template: jinja
  - mode: '{{ server.local_settings_mode }}'
  - user: '{{ server.local_settings_user }}'
  - group: '{{ server.local_settings_group }}'
  - require:
    - pkg: horizon_packages

horizon_webserver_config:
  file.managed:
  - name: {{ server.webserver_config }}
  - source: salt://horizon/files/openstack-dashboard.conf
  - template: jinja
  - mode: '0644'
  - user: 'root'
  - group: 'root'
  - require:
    - pkg: horizon_packages
