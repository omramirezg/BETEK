# ============================================================
# main.tf (Modulo s3_website) - Aqui creo todos los recursos
# necesarios para tener un sitio web estatico en S3:
# el bucket, la configuracion de hosting, el acceso publico,
# la policy y subo el archivo index.html.
# ============================================================

# --- 1. CREAR EL BUCKET S3 ---
# Este es el "contenedor" donde se almacena la pagina web.
# El nombre viene de la variable, nunca se hardcodea.
resource "aws_s3_bucket" "website" {
  bucket = var.nombre_bucket # Nombre dinamico del bucket, viene de terraform.tfvars
  tags   = var.tags          # Tags obligatorios (Environment, Owner, Project)
}

# --- 2. CONFIGURAR EL HOSTING DE SITIO WEB ESTATICO ---
# Le digo a S3 que este bucket funcione como un servidor web.
# Cuando alguien acceda a la URL, S3 va a servir el index.html
# como pagina principal.
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website.id # Referencia al bucket que cree arriba

  # Documento principal: cuando alguien entre a la URL, se muestra este archivo
  index_document {
    suffix = "index.html"
  }

  # Documento de error: si piden una pagina que no existe, tambien muestro el index
  error_document {
    key = "index.html"
  }
}

# --- 3. DESACTIVAR EL BLOQUEO DE ACCESO PUBLICO ---
# Por defecto AWS bloquea todo acceso publico a los buckets (por seguridad).
# Como necesito que la pagina sea visible desde el navegador,
# tengo que desactivar esos bloqueos.
resource "aws_s3_bucket_public_access_block" "website" {
  bucket = aws_s3_bucket.website.id # Referencia al bucket

  block_public_acls       = false # Permito ACLs publicas
  block_public_policy     = false # Permito policies publicas
  ignore_public_acls      = false # No ignoro las ACLs publicas
  restrict_public_buckets = false # No restrinjo buckets publicos
}

# --- 4. POLICY DE ACCESO PUBLICO (LECTURA) ---
# Esta policy permite que CUALQUIER persona en internet
# pueda leer (GET) los archivos del bucket.
# Sin esto, aunque desactive los bloqueos, nadie podria ver la pagina.
resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id # Referencia al bucket

  # depends_on asegura que primero se desactiven los bloqueos
  # y despues se aplique la policy. Si no, AWS la rechaza.
  depends_on = [aws_s3_bucket_public_access_block.website]

  # La policy en formato JSON dice:
  # "Permitir (Allow) a cualquiera (*) hacer GetObject en todos los archivos del bucket"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"            # Identificador de la regla
        Effect    = "Allow"                          # Permitir la accion
        Principal = "*"                              # A cualquier persona (publico)
        Action    = "s3:GetObject"                   # Solo lectura de archivos
        Resource  = "${aws_s3_bucket.website.arn}/*" # Todos los archivos dentro del bucket
      }
    ]
  })
}

# --- 5. SUBIR EL ARCHIVO INDEX.HTML ---
# Subo la pagina web al bucket. El content_type es importante
# para que el navegador sepa que es HTML y lo renderice bien.
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.website.id # En cual bucket lo subo
  key          = "index.html"             # Nombre del archivo dentro del bucket
  content_type = "text/html"              # Tipo de contenido: HTML

  # Genero el HTML dinamicamente con el nombre del estudiante y la fecha.
  # Uso templatefile para no hardcodear nada en el HTML.
  content = templatefile("${path.module}/templates/index.html.tftpl", {
    nombre_estudiante = var.nombre_estudiante
    fecha_actual      = formatdate("DD/MM/YYYY", timestamp())
  })

  tags = var.tags # Tags obligatorios
}
