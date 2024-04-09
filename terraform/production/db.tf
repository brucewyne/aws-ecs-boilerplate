resource "aws_db_subnet_group" "main" {
  name       = "DB - production"
  subnet_ids = [aws_subnet.main.id]
}

resource "aws_db_instance" "dev_database" {
  allocated_storage    = 20
  max_allocated_storage = 100 // for autoscaling the storage
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "dbadmin"
  password             = "adminpassword" //change this after, or load it from a GH secret
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.main.name
}
