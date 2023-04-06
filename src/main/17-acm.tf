# TLS Certificates
resource "aws_acm_certificate" "website" {
  domain_name       = keys(var.public_dns_zones)[0]
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  provider = aws.us-east-1
}