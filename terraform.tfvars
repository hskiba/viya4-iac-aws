# !NOTE! - These are only a subset of the variables in CONFIG-VARS.md provided
# as examples. Customize this file to add any variables from CONFIG-VARS.md whose
# default values you want to change.

# ****************  REQUIRED VARIABLES  ****************
# These required variables' values MUST be provided by the User
prefix   = "sample"
location = "ap-southeast-5" # e.g., "us-east-1"
# ****************  REQUIRED VARIABLES  ****************

# !NOTE! - Without specifying your CIDR block access rules, ingress traffic
#          to your cluster will be blocked by default.

# **************  RECOMMENDED  VARIABLES  ***************
default_public_access_cidrs = ["202.186.1.58/32"] # e.g., ["123.45.6.89/32"]
ssh_public_key              = "~/.ssh/id_rsa.pub"
# **************  RECOMMENDED  VARIABLES  ***************

# Tags for all tagable items in your cluster.
tags = {
  "Environment" = "Sample Viya Deployment"
  } # e.g., { "key1" = "value1", "key2" = "value2" }

# Postgres config - By having this entry a database server is created. If you do not
#                   need an external database server remove the 'postgres_servers'
#                   block below.
# postgres_servers = {
#   default = {},
# }

## Cluster config
kubernetes_version           = "1.29"
default_nodepool_node_count  = 1
default_nodepool_vm_type     = "m7i-flex.large"
default_nodepool_custom_data = ""

## General
efs_performance_mode = "maxIO"
storage_type         = "standard"

## Cluster Node Pools config - minimal
cluster_node_pool_mode = "minimal"
node_pools = {
  cas = {
    "vm_type"      = "r7i.xlarge"
    "cpu_type"     = "AL2_x86_64"
    "os_disk_type" = "gp3"
    "os_disk_size" = 100
    "os_disk_iops" = 2
    "min_nodes"    = 0
    "max_nodes"    = 5
    "node_taints"  = ["workload.sas.com/class=cas:NoSchedule"]
    "node_labels" = {
      "workload.sas.com/class" = "cas"
    }
    "custom_data"                          = ""
    "metadata_http_endpoint"               = "enabled"
    "metadata_http_tokens"                 = "required"
    "metadata_http_put_response_hop_limit" = 1
  },
  generic = {
    "vm_type"      = "m7i-flex.2xlarge"
    "cpu_type"     = "AL2_x86_64"
    "os_disk_type" = "gp3"
    "os_disk_size" = 200
    "os_disk_iops" = 0
    "min_nodes"    = 0
    "max_nodes"    = 5
    "node_taints"  = []
    "node_labels" = {
      "workload.sas.com/class"        = "compute"
      "launcher.sas.com/prepullImage" = "sas-programming-environment"
    }
    "custom_data"                          = ""
    "metadata_http_endpoint"               = "enabled"
    "metadata_http_tokens"                 = "required"
    "metadata_http_put_response_hop_limit" = 1
  }
}

# Jump Server
create_jump_vm = true
jump_vm_admin  = "jumpuser"
jump_vm_type   = "t3a.small"

# NFS Server
# required ONLY when storage_type is "standard" to create NFS Server VM
create_nfs_public_ip = false
nfs_vm_admin         = "nfsuser"
nfs_vm_type          = "m7i-flex.xlarge"
