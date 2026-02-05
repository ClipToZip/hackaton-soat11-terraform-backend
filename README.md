# hackaton-soat11-terraform-backend

# Setup do Backend Terraform

Este diretório contém a configuração para criar os recursos necessários para o backend do Terraform (bucket S3 e tabela DynamoDB).

## Passos para Configuração

### 1. Configurar Backend (EXECUTAR APENAS UMA VEZ)

```bash
# Navegar para o diretório de setup
cd terraform

# Inicializar Terraform
terraform init

# Planejar a criação dos recursos
terraform plan

# Aplicar a configuração
terraform apply

# Anotar os outputs (bucket S3 e tabela DynamoDB)
```

### 2. Migrar Estado Existente (SE JÁ TIVER INFRAESTRUTURA)

Se você já tem infraestrutura criada localmente:

```bash
# Voltar para o diretório principal
cd ../terraform

# Inicializar com o novo backend
terraform init

# O Terraform vai perguntar se você quer migrar o estado existente
# Responda "yes" para migrar o tfstate local para o S3
```

### 3. Para Nova Infraestrutura

Se for começar do zero:

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

## Estrutura

```
terraform/          # Configuração do backend (bucket S3 + DynamoDB)
  ├── main.tf
  └── providers.tf
```