# ============================================================
# terraform.tfvars - Aqui asigno los valores reales a las variables.
# Este archivo se lee automaticamente cuando hago terraform plan/apply.
# Es donde personalizo el despliegue sin tocar el codigo principal.
# ============================================================

region            = "us-east-1"
nombre_bucket     = "cloudnova-examen-omar-ramirez-2026"
nombre_estudiante = "Omar Ramirez Gonzalez"
environment       = "dev"
project           = "Betek"
