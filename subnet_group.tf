resource "aws_db_subnet_group" "db" {
  name       = "db"
  subnet_ids = var.subnet_ids

}