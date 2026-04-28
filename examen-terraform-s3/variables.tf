# ============================================================
# variables.tf (Root) - Aqui defino todas las variables globales
# del proyecto para no tener NADA hardcodeado en el codigo.
# Cada variable tiene su descripcion, tipo y valor por defecto
# cuando tiene sentido tenerlo.
# ============================================================

# Region de AWS donde se van a crear los recursos
# La dejo con default "us-east-1" porque es la mas comun y
# la que mejor soporta S3 static website hosting
variable "region" {
  description = "Region de AWS donde se desplegaran los recursos"
  type        = string
  default     = "us-east-1"
}

# Nombre del bucket S3 - debe ser unico a nivel global en AWS
# No le pongo default porque cada estudiante debe poner el suyo
variable "nombre_bucket" {
  description = "Nombre unico para el bucket S3 que alojara el sitio web"
  type        = string
}

# Nombre del estudiante - se usa en los tags y en el index.html
variable "nombre_estudiante" {
  description = "Nombre completo del estudiante para tags y pagina web"
  type        = string
}

# Ambiente de despliegue (dev, staging, prod)
# Lo dejo en dev porque el examen lo pide asi
variable "environment" {
  description = "Ambiente de despliegue (dev, staging, prod)"
  type        = string
  default     = "dev"
}

# Nombre del proyecto - lo pide el examen como tag obligatorio
variable "project" {
  description = "Nombre del proyecto para el tag obligatorio"
  type        = string
  default     = "Betek"
}
