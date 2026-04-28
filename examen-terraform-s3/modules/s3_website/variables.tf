# ============================================================
# variables.tf (Modulo s3_website) - Variables que recibe este
# modulo desde el root. El modulo no sabe nada del exterior,
# solo trabaja con lo que le pasen por aqui.
# ============================================================

# Nombre del bucket - viene del root, no tiene default
# porque es obligatorio y debe ser unico en todo AWS
variable "nombre_bucket" {
  description = "Nombre unico para el bucket S3"
  type        = string
}

# Nombre del estudiante - lo uso para generar el index.html
# dinamicamente con el nombre correcto
variable "nombre_estudiante" {
  description = "Nombre del estudiante que aparecera en la pagina web"
  type        = string
}

# Tags - vienen del root como un mapa de key-value
# Asi el modulo no necesita saber cuales son, solo los aplica
variable "tags" {
  description = "Tags obligatorios que se aplican a todos los recursos"
  type        = map(string)
}
