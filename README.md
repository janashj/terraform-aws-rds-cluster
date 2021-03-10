# terraform-aws-rds-cluster
This module creates AWS RDS Database for Aurora.  

You can use below module in 2 different ways. 
1) You can create your own .tf file, copy and paste this module in it and give values directly to variables as below:
```
module "rds_cluster" {
  source = "github.com/janashj/terraform-aws-rds-cluster"
  region = "us-east-1"
  subnet_ids = [
    "subnet-your-subnet-ids",
    "subnet-your-subnet-ids",
    "subnet-your-subnet-ids"
  ]
  identifier          = "mydb"
  allocated_storage   = 20
  storage_type        = "gp2"
  engine              = "mysql"
  engine_version      = "5.7"
  instance_class      = "db.t2.micro"
  username            = "foo"
  password            = "foobarbaz"
  publicly_accessible = true

  db_access = [
    "0.0.0.0/0"
    ]
}
```

2) or, in this case you have to create 3 files, 1 module.tf, 1 region.tfvars, 1 variables.tf. 
Copy and paste below codes to those 3 files:

module.tf:
```
module "rds_cluster" {
  source              = "github.com/janashj/terraform-aws-rds-cluster"
  region              = var.region
  subnet_ids          = var.subnet_ids
  identifier          = var.cluster_identifier
  allocated_storage   = var.allocated_storage
  storage_type        = var.storage_type
  engine              = var.engine
  engine_version      = var.engine_version
  instance_class      = var.instance_class
  username            = var.username
  password            = var.password
  publicly_accessible = var.publicly_accessible
  db_access           = var.db_access
}
```
region.tfvars:
```
region = "us-east-1"
subnet_ids = [
  "subnet-yoursubnetid",
  "subnet-yoursubnetid",
  "subnet-yoursubnetid"
]
cluster_identifier  = "mydb"
allocated_storage   = 20
storage_type        = "gp2"
engine              = "aurora-mysql"
engine_version      = "5.7"
instance_class      = "db.t2.micro"
username            = "foo"
publicly_accessible = true

db_access = [
  "50.194.68.233/32",
  "50.194.68.235/32",
  "0.0.0.0/0"
]
```
variables.tf:
```
variable "region" {}
variable "subnet_ids" {
  type = list(any)
}
variable "db_access" {
  type = list(any)
}
variable "cluster_identifier" {}
variable "allocated_storage" {}
variable "engine" {}
variable "storage_type" {}
variable "engine_version" {}
variable "instance_class" {}
variable "username" {}
variable "password" {}
variable "publicly_accessible" {}

```

/* module cant pull the value of each resource, so if we want to
use output, then output.tf file should be created first. 
Optionally, you can copy and paste below code inside your module.tf file for outputs.
##### Note: output.tf file is created in the repository, so no need to create here, go ahead with pasting this code if you need outputs. 
*/
```
output "region" {
  value = module.rds_cluster.region
}
output "subnet_list" {
  value = module.rds_cluster.subnet_list
}
output "db_access" {
  value = module.rds_cluster.db_access
}
output "DB_name" {
  value = module.rds_cluster.DB_name
}
output "endpoint" {
  value = module.rds_cluster.Endpoint
}
```

# To run:

With 1st option you have to run:
##### terraform init
##### terraform apply
______

With 2nd option you have to run:
##### terraform init
##### terraform apply -var-file region.tfvars

_____________________
##### Note: at times you have to run terraform apply -var-file region.tfvars 2 times, since first time it will create rds itself, and only 2nd time its clusters.
###### Please note: password is saved in AWS SSM 
