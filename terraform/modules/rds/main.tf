resource "aws_db_subnet_group" "main" {
  name       = "enterprise-rds-subnet-group"
  subnet_ids = var.subnet_ids
  tags = {
    Name = "enterprise-rds-subnet-group"
  }
}

resource "aws_db_instance" "main" {
  identifier              = "enterprise-rds-db"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = var.db_instance_type
  allocated_storage       = 20
  storage_encrypted       = true
  username                = var.db_username
  password                = var.db_password
  db_name                 = var.db_name
  skip_final_snapshot     = true
  publicly_accessible     = var.public_access
  vpc_security_group_ids  = [aws_security_group.rds.id]
  db_subnet_group_name    = aws_db_subnet_group.main.name
  backup_retention_period = 7
  deletion_protection     = false
  tags = {
    Name = "enterprise-rds-db"
  }
}

resource "aws_security_group" "rds" {
  name        = "enterprise-rds-sg"
  vpc_id      = var.vpc_id
  description = "Allow traffic from EKS to RDS MySQL"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
