# ============================================================
# outputs.tf (Modulo s3_website) - Expongo la informacion
# del modulo hacia el root para que pueda mostrarla al final.
# ============================================================

# URL del sitio web - esta es la URL que se abre en el navegador
# S3 genera automaticamente esta URL cuando activo el hosting estatico
output "website_url" {
  description = "URL del sitio web estatico alojado en S3"
  value       = "http://${aws_s3_bucket_website_configuration.website.website_endpoint}"
}

# ID del bucket - nombre del bucket creado
output "bucket_id" {
  description = "ID (nombre) del bucket S3"
  value       = aws_s3_bucket.website.id
}

# ARN del bucket - identificador unico del recurso en AWS
output "bucket_arn" {
  description = "ARN del bucket S3"
  value       = aws_s3_bucket.website.arn
}
