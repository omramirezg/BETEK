# ============================================================
# main.tf (Root) - Archivo principal que configura Terraform,
# el provider de AWS y llama al modulo de S3 website.
# Aqui no creo recursos directamente, solo orquesto el modulo.
# ============================================================

# Bloque terraform: defino la version minima de Terraform
# y el provider que necesito (AWS en este caso)
terraform {
  required_version = ">= 1.5" # Necesito Terraform 1.5 o superior para que funcione todo bien

  required_providers {
    aws = {
      source  = "hashicorp/aws" # El provider oficial de AWS mantenido por HashiCorp
      version = "~> 5.0"        # Uso la version 5.x (el ~> permite actualizaciones menores)
    }
  }
}

# Configuro el provider de AWS con la region que viene de la variable
# Asi no hardcodeo la region, sino que la paso desde terraform.tfvars
provider "aws" {
  region = var.region # La region se define en variables.tf y se asigna en terraform.tfvars
}

# Defino los tags comunes que van en TODOS los recursos
# Los centralizo aqui para no repetirlos en cada recurso
locals {
  tags_comunes = {
    Environment = var.environment       # "dev" - ambiente de despliegue
    Owner       = var.nombre_estudiante # "Omar Ramirez Gonzalez" - dueno del recurso
    Project     = var.project           # "Betek" - proyecto al que pertenece
  }
}

# Llamo al modulo s3_website que crea toda la infraestructura
# del bucket S3 con hosting estatico. Le paso las variables
# que necesita para funcionar.
module "s3_website" {
  source = "./modules/s3_website" # Ruta al modulo local

  nombre_bucket     = var.nombre_bucket     # Nombre del bucket S3
  nombre_estudiante = var.nombre_estudiante # Para el index.html
  tags              = local.tags_comunes    # Tags obligatorios
}
