# TLS Certificates
## In use by the ALB (apex record)
resource "aws_acm_certificate" "website" {
  domain_name       = keys(var.public_dns_zones)[0]
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

}

# TLS Certificates 
## CDN custom domain
resource "aws_acm_certificate" "www_website" {
  domain_name       = format("www.%s", keys(var.public_dns_zones)[0])
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  provider = aws.us-east-1
}