# -*- coding: utf-8 -*-
# vim: ft=sls

include:
  - horizon.config
  - horizon.service

extend:
  horizon_service__restart:
    module:
      - require:
        - sls: horizon.config
      - watch:
        - file: horizon_config__local_settings
        - file: horizon_config__webserver_config
