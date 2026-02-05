# 1. Criar bucket S3 para armazenar o tfstate
resource "aws_s3_bucket" "terraform_state" {
  bucket = "hackaton-soat11-cliptozip-tfstate"  # Mude para um nome único
  
  tags = {
    Name        = "Terraform State Bucket"
    Environment = "Development"
    Project     = "Hackaton Soat11 ClipToZip"
  }
}

# 2. Configurar versionamento do bucket
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# 3. Configurar criptografia do bucket  
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# 4. Bloquear acesso público
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# 5. Criar tabela DynamoDB para lock de estado
resource "aws_dynamodb_table" "terraform_locks" {
  name           = "hackaton-soat11-cliptozip-terraform-locks"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "Terraform State Lock Table"
    Environment = "Development"
    Project     = "Hackaton Soat11 ClipToZip"
  }
}

# Outputs para confirmar a criação
output "s3_bucket_name" {
  value = aws_s3_bucket.terraform_state.id
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_locks.name
}