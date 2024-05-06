pychunkedgraph:
  version: 2.15.1
  # should be a list of graphIds seperated by commas
  graphIds: ""
  secretFiles:
    # need to fill in with path to service account secret file
    - name: google-secret.json
      value: ""
    # need to fill in with path to secret file
    - name: cave-secret.json
      value: ""
    # should add any other secret files you need here
  config: ""
  redis:
    host: ${redis_ip}
    port: 6379
  bigtableInstanceName: "${big_table_instance_name}"
  writeMinReplicas: 1
  writeMaxReplicas: 3
  writeMemGb: 4
  writeCpuMilli: 500
  readMinReplicas: 1
  readMaxReplicas: 10
  readMemGb: 1.8
  readCpuMilli: 125
  meshMinReplicas: 1
  meshMaxReplicas: 3
  meshMemGb: 4
  meshCpuMilli: 1000
  meshWorkerMinReplicas: 1
  meshWorkerMaxReplicas: 10
  remeshQueue: ${remesh_queue}
  # should be enable or left blank
  enableLogs: "enable"
  # should be the name of table you want to log leave_many for
  logsLeavesMany: ""
  limitsFastQueryPerMinute: 1000
  limitsQueryPerMinute: 100
  uwsgiReadIni: "uwsgi.ini"