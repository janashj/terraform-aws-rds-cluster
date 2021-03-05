output "region" {
  value = var.region
}
output "subnet_list" {
  value = var.subnet_ids
}
output "db_access" {
  value = var.db_access
}
output "DB_name" {
  value = aws_rds_cluster.rds.cluster_identifier
}
output "Endpoint" {
  value = aws_rds_cluster.rds.endpoint
}
