# -*- coding: utf-8 -*-
# vim: ft=sls

{%- from "horizon/map.jinja" import server with context %}

horizon_service__restart:
  module.wait:
    - name: cmd.run
    - cmd: {{server.restartcommand}}
    - python_shell: True
