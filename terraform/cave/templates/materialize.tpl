materialize:
  version: "4.23.2"
  datastacks: ""
  apiMinReplicas: 1
  apiMaxReplicas: 5
  producerMinReplicas: 2
  producerMaxReplicas: 5
  consumerMinReplicas: 1
  consumerMaxReplicas: 50
  minDatabases: 1
  maxDatabases: 3
  limitsQueryPerMinute: 300
  limitsFastQueryPerMinute: 2000
  celeryProducerCpu: "100m"
  celeryProducerMemory: "400Mi"
  celeryConsumerCpu: "100m"
  celeryConsumerMemory: "400Mi"
  redis:
    host: ${redis_ip}
    port: "6379"
    password: ""