region = "us-east-2"
subnet_ids = [
  "subnet-08b89c0bd842fd930",
  "subnet-064d03b216d6024de",
  "subnet-040bcd4f261129b78"
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