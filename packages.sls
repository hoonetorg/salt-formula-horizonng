{%- from "horizon/map.jinja" import server with context %}

horizon_packages__packages:
  pkg.installed:
  - names: {{ server.pkgs }}

