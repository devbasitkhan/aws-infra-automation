resource "aws_security_group" "database" {
  name        = "portfolio-db-sg"
  description = "Allow MySQL only from the application EC2 security group"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "MySQL from web server"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "portfolio-db-sg"
  }
}

resource "aws_db_subnet_group" "main" {
  name = "portfolio-db-subnets"
  subnet_ids = [
    aws_subnet.private_db_a.id,
    aws_subnet.private_db_b.id
  ]

  tags = {
    Name = "portfolio-db-subnets"
  }
}

resource "aws_db_instance" "main" {
  identifier             = "portfolio-mysql"
  allocated_storage      = 20
  storage_type           = "gp3"
  engine                 = "mysql"
  instance_class         = "db.t3.micro"
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.database.id]
  publicly_accessible    = false
  skip_final_snapshot    = true

  tags = {
    Name = "portfolio-mysql"
  }
}
