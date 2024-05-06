# helmfile.yaml
releases:
  - name: materialization-engine
    namespace: default
    chart: ../../charts/materializationengine
    version: 0.1.0
    values:
      - cluster.yaml   # Specific values for ltv5 cluster
      - materialize.yaml  # Specific values for materialization
      - annotation.yaml  # Specific values for annotation
      - cloudsql.yaml # Specific values for cloudsql
    secrets:
      - secrets.yaml
    set:
      - name: materialize.schedules
        file: materialization_schedule.json
  - name: annotation-engine
    namespace: default
    chart: ./charts/annotationengine
    version: 0.1.0
    values:
      - cluster.yaml   # Specific values for ltv5 cluster
      - annotation.yaml  # Specific values for annotation
      - cloudsql.yaml # Specific values for cloudsql
    secrets:
      - secrets.yaml
  - name: pychunkedgraph
    namespace: default
    chart: ./charts/pychunkedgraph
    version: 0.1.0
    values:
      - cluster.yaml  # Specific values for ltv5 cluster
      - pychunkedgraph.yaml # Specific values for pychunkedgraph
    secrets:
      - secrets.yaml
    set:
      - name: pychunkedgraph.redis.host
        value: $mpcg_redis_ip
  - name: dash
    namespace: default
    chart: ./charts/dash
    version: 0.1.0
    values:
      - cluster.yaml  # Specific values for ltv5 cluster
      - dash.yaml # Specific values for clodashudsql
    secrets:
      - secrets.yaml
    set:
      - name: dash.config
        file: "dash_config.py"