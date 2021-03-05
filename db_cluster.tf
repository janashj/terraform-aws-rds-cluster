resource "aws_rds_cluster" "rds" {
  cluster_identifier   = var.cluster_identifier
  engine               = var.engine
  engine_version       = var.engine_version
  database_name        = var.cluster_identifier
  master_username      = var.username
  master_password      = random_password.password.result
  db_subnet_group_name = aws_db_subnet_group.db.name
  skip_final_snapshot  = true # you have to mention this, otherwise it will create snapshots
  vpc_security_group_ids = [
    aws_security_group.db.id
  ]
}
resource "aws_rds_cluster_instance" "cluster_instances" {
  count               = 2
  identifier          = "aurora-cluster-demo-${count.index + 1}"
  cluster_identifier  = var.cluster_identifier
  instance_class      = "db.r4.large"
  engine              = var.engine
  engine_version      = var.engine_version
  publicly_accessible = var.publicly_accessible
}