resource "aws_db_subnet_group" "main" {
  name       = "DB - dev"
  subnet_ids = [aws_subnet.main.id]
}

# this allows us to use this development DB locally
# modify or remove this to meet your security needs
resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
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
  publicly_accessible  = true
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.allow_all.id]
}
