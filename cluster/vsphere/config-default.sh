#!/bin/bash

# Copyright 2014 The Kubernetes Authors All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

NUM_MINIONS=4
DISK=./kube/kube.vmdk
GUEST_ID=debian7_64Guest

INSTANCE_PREFIX=kubernetes
MASTER_TAG="${INSTANCE_PREFIX}-master"
MINION_TAG="${INSTANCE_PREFIX}-minion"

MASTER_NAME="${INSTANCE_PREFIX}-master"
MASTER_MEMORY_MB=1024
MASTER_CPU=1

MINION_NAMES=($(eval echo ${INSTANCE_PREFIX}-minion-{1..${NUM_MINIONS}}))
MINION_IP_RANGES=($(eval echo "10.244.{1..${NUM_MINIONS}}.0/24"))
MINION_MEMORY_MB=2048
MINION_CPU=1

SERVICE_CLUSTER_IP_RANGE="10.244.240.0/20"  # formerly PORTAL_NET

# Optional: Enable node logging.
ENABLE_NODE_LOGGING=false
LOGGING_DESTINATION=elasticsearch

# Optional: When set to true, Elasticsearch and Kibana will be setup as part of the cluster bring up.
ENABLE_CLUSTER_LOGGING=false
ELASTICSEARCH_LOGGING_REPLICAS=1

# Optional: Cluster monitoring to setup as part of the cluster bring up:
#   none     - No cluster monitoring setup 
#   influxdb - Heapster, InfluxDB, and Grafana 
#   google   - Heapster, Google Cloud Monitoring, and Google Cloud Logging
ENABLE_CLUSTER_MONITORING="${KUBE_ENABLE_CLUSTER_MONITORING:-influxdb}"

# Optional: Install cluster DNS.
ENABLE_CLUSTER_DNS=true
DNS_SERVER_IP="10.244.240.240"
DNS_DOMAIN="cluster.local"
DNS_REPLICAS=1
