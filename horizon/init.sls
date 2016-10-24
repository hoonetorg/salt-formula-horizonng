# -*- coding: utf-8 -*-
# vim: ft=sls

include:
  - horizon.config
  - horizon.service

extend:
  horizon_restart:
    module:
      - require:
        - sls: horizon.config
