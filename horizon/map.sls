# -*- coding: utf-8 -*-
# vim: ft=sls

{%- from "horizon/map.jinja" import server with context %}

horizon_map__server.map:
  file.managed:
    - name: /tmp/server.map
    - contents: |
        {{server|yaml(False)|indent(8)}}
