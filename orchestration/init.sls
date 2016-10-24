#!jinja|yaml
{%- set node_ids = salt['pillar.get']('horizon:server:pcs:node_ids') -%}
{%- set admin_node_id = salt['pillar.get']('horizon:server:pcs:admin_node_id') -%}

# node_ids: {{node_ids|json}}
# admin_node_id: {{admin_node_id}}

{%- for node_id in node_ids %}
horizon_orchestration__install_{{node_id}}:
  salt.state:
    - tgt: {{node_id}}
    - expect_minions: True
    - sls: horizon.config
    - require_in:
      - salt: horizon_orchestration__pcs
{%- endfor %}

horizon_orchestration__pcs:
  salt.state:
    - tgt: {{admin_node_id}}
    - expect_minions: True
    - sls: horizon.pcs

{%- for node_id in node_ids %}
horizon_orchestration__service_{{node_id}}:
  salt.state:
    - tgt: {{node_id}}
    - expect_minions: True
    - sls: horizon.service
    - require:
      - salt: horizon_orchestration__pcs
{%- endfor %}
