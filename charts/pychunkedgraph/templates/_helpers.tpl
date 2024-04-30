{{- define "pcg_env.config" -}}
- name: GOOGLE_APPLICATION_CREDENTIALS
  value: /home/nginx/.cloudvolume/secrets/google-secret.json
- name: MANIFEST_CACHE_REDIS_HOST
  value: {{ .Values.pychunkedgraph.redis.host }}
- name: REDISHOST
  value: {{ .Values.pychunkedgraph.redis.host }}
- name: AUTH_URI
  value: {{ .Values.cluster.globalServer }}/auth
- name: STICKY_AUTH_URL
  value: {{ .Values.cluster.globalServer }}/sticky_auth
- name: AUTH_URL
  value: {{ .Values.cluster.globalServer }}/auth
- name: BIGTABLE_PROJECT
  value: {{ .Values.cluster.dataProjectName }}
- name: BIGTABLE_INSTANCE
  value: {{ .Values.pychunkedgraph.bigtableInstanceName}}
- name: INFO_URL
  value: {{ .Values.cluster.globalServer }}/info
- name: REDIS_SERVICE_HOST
  value: {{ .Values.pychunkedgraph.redis.host }}
- name: REDIS_SERVICE_PORT
  value: {{ .Values.pychunkedgraph.redis.port }}
- name: APP_SETTINGS
  value: "pychunkedgraph.app.config.DevelopmentConfig"
- name: PROJECT_ID
  value: {{ .Values.cluster.dataProjectName }}
- name: SEGMENTATION_URL_PREFIX
  value: segmentation
- name: PROJECT_NAME
  value: {{ .Values.cluster.googleProject }}
- name: PYCHUNKEDGRAPH_REMESH_QUEUE
  value: "{{ .Values.cluster.environment }}_PCG_HIGH_PRIORITY_REMESH"
- name: PYCHUNKEDGRAPH_EDITS_EXCHANGE
  value: "{{ .Values.cluster.environment }}_PCG_EDIT"
- name: PYCHUNKEDGRAPH_EDITS_LOW_PRIORITY_EXCHANGE
  value: "{{ .Values.cluster.environment }}_PCG_LOW_PRIORITY_REMESH"
- name: PCG_SERVER_LOGS_PROJECT
  value: {{ .Values.cluster.googleProject }}
- name: PCG_SERVER_LOGS_NS
  value: pcg_server_logs_{{ .Values.cluster.environment }}
- name: PCG_SERVER_ENABLE_LOGS
  value: {{ .Values.pychunkedgraph.enableLogs | default "enable"}}
- name: PCG_SERVER_LOGS_LEAVES_MANY
  value: {{ .Values.pychunkedgraph.logsLeavesMany }}
- name: PCG_GRAPH_IDS
  value: {{ .Values.pychunkedgraph.graphIds | toJson}}
- name: PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION
  value: "upb"
- name: ZSTD_THREADS
  value: "4"
- name: MESHING_URL_PREFIX
  value: meshing
- name: AUTH_USE_REDIS
  value: "false"
- name: DAF_CREDENTIALS
  value: /home/nginx/.cloudvolume/secrets/cave-secret.json
- name: LIMITER_CATEGORIES
  value: '{"query":"{{ .Values.pychunkedgraph.limitsFastQueryPerMinute | default 2000}}/minute","fast_query":"{{ .Values.pychunkedgraph.limitsQueryPerMinute | default 100}}/minute"}'
- name: LIMITER_URI
  value: redis://{{ .Values.limiter.redis.host }}/0 
{{- end -}}

{{- define "sysctl.config" -}}
- name: sysctl-buddy
  image: alpine:3.4
  command:
    - /bin/sh
    - -c
    - |
      while true; do
        sysctl -w net.core.somaxconn=32768
        sysctl -w net.ipv4.ip_local_port_range='1024 65535'
        sleep 100
      done
  imagePullPolicy: IfNotPresent
  securityContext:
  privileged: true
  resources:
  requests:
    memory: 10Mi
    cpu: 5m
{{- end -}}
