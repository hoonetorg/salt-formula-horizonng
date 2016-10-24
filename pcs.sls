# -*- coding: utf-8 -*-
# vim: ft=sls
{%- from "horizon/map.jinja" import server with context %}

{% set pcs = server.get('pcs', {}) %}

{% if pcs.horizon_cib is defined and pcs.horizon_cib %}
horizon_pcs__cib_present_{{pcs.horizon_cib}}:
  pcs.cib_present:
    - cibname: {{pcs.horizon_cib}}
{% endif %}

{% if 'resources' in pcs %}
{% for resource, resource_data in pcs.resources.items()|sort %}
horizon_pcs__resource_present_{{resource}}:
  pcs.resource_present:
    - resource_id: {{resource}}
    - resource_type: "{{resource_data.resource_type}}"
    - resource_options: {{resource_data.resource_options|json}}
{% if pcs.horizon_cib is defined and pcs.horizon_cib %}
    - require:
      - pcs: horizon_pcs__cib_present_{{pcs.horizon_cib}}
    - require_in:
      - pcs: horizon_pcs__cib_pushed_{{pcs.horizon_cib}}
    - cibname: {{pcs.horizon_cib}}
{% endif %}
{% endfor %}
{% endif %}

{% if 'constraints' in pcs %}
{% for constraint, constraint_data in pcs.constraints.items()|sort %}
horizon_pcs__constraint_present_{{constraint}}:
  pcs.constraint_present:
    - constraint_id: {{constraint}}
    - constraint_type: "{{constraint_data.constraint_type}}"
    - constraint_options: {{constraint_data.constraint_options|json}}
{% if pcs.horizon_cib is defined and pcs.horizon_cib %}
    - require:
      - pcs: horizon_pcs__cib_present_{{pcs.horizon_cib}}
    - require_in:
      - pcs: horizon_pcs__cib_pushed_{{pcs.horizon_cib}}
    - cibname: {{pcs.horizon_cib}}
{% endif %}
{% endfor %}
{% endif %}

{% if pcs.horizon_cib is defined and pcs.horizon_cib %}
horizon_pcs__cib_pushed_{{pcs.horizon_cib}}:
  pcs.cib_pushed:
    - cibname: {{pcs.horizon_cib}}
{% endif %}

horizon_pcs__empty_sls_prevent_error:
  cmd.run:
    - name: true
    - unless: true
