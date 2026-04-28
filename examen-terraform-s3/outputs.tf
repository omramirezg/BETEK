# ============================================================
# outputs.tf (Root) - Muestro la informacion importante despues
# del despliegue. Basicamente la URL donde queda la pagina web
# para poder abrirla en el navegador.
# ============================================================

# URL del sitio web estatico - la que abro en el navegador
# para ver la pagina de bienvenida funcionando
output "url_sitio_web" {
  description = "URL publica del sitio web estatico en S3"
  value       = module.s3_website.website_url
}

# ID del bucket - util para referencia o si necesito
# hacer algo mas con el bucket despues
output "bucket_id" {
  description = "ID del bucket S3 creado"
  value       = module.s3_website.bucket_id
}

# ARN del bucket - identificador unico en AWS
output "bucket_arn" {
  description = "ARN del bucket S3"
  value       = module.s3_website.bucket_arn
}
