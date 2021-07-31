terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 1.0.2"
}

provider "aws" {
  access_key = "xxxxxxxxxxxxxxxxxxxxx"
  secret_key = "xxxxxxxxxxxxxxxxxxxxx"
  profile    = "default"
  region     = "ap-southeast-1"
}

resource "aws_route53_zone" "main" {
  name = "fiardika.xyz"
}

resource "aws_route53_zone" "k8s" {
  name = "k8s.fiardika.xyz"
}

resource "aws_route53_record" "k8s" {
  zone_id         = aws_route53_zone.main.id
  name            = "k8s.fiardika.xyz"
  type            = "NS"
  ttl             = 30
  allow_overwrite = true
  records = [
    aws_route53_zone.k8s.name_servers[0],
    aws_route53_zone.k8s.name_servers[1],
    aws_route53_zone.k8s.name_servers[2],
    aws_route53_zone.k8s.name_servers[3],
  ]
}

resource "aws_route53_record" "landing" {
  zone_id         = aws_route53_zone.main.id
  name            = "fiardika.fiardika.xyz"
  type            = "CNAME"
  ttl             = 60
  allow_overwrite = true
  records         = ["ad464fb41a51346c6b87e5192017153c-bfa250d72cfa6fdd.elb.ap-southeast-1.amazonaws.com"]
}

resource "aws_route53_record" "pesbuk" {
  zone_id         = aws_route53_zone.main.id
  name            = "pesbuk.fiardika.xyz"
  type            = "CNAME"
  ttl             = 60
  allow_overwrite = true
  records         = ["ad464fb41a51346c6b87e5192017153c-bfa250d72cfa6fdd.elb.ap-southeast-1.amazonaws.com"]
}

resource "aws_route53_record" "wordpress" {
  zone_id         = aws_route53_zone.main.id
  name            = "blog.fiardika.xyz"
  type            = "CNAME"
  ttl             = 60
  allow_overwrite = true
  records         = ["ad464fb41a51346c6b87e5192017153c-bfa250d72cfa6fdd.elb.ap-southeast-1.amazonaws.com"]
}

resource "aws_route53_record" "stag_landing" {
  zone_id         = aws_route53_zone.main.id
  name            = "fiardika-staging.fiardika.xyz"
  type            = "CNAME"
  ttl             = 60
  allow_overwrite = true
  records         = ["ad464fb41a51346c6b87e5192017153c-bfa250d72cfa6fdd.elb.ap-southeast-1.amazonaws.com"]
}

resource "aws_route53_record" "stag_pesbuk" {
  zone_id         = aws_route53_zone.main.id
  name            = "pesbuk-staging.fiardika.xyz"
  type            = "CNAME"
  ttl             = 60
  allow_overwrite = true
  records         = ["ad464fb41a51346c6b87e5192017153c-bfa250d72cfa6fdd.elb.ap-southeast-1.amazonaws.com"]
}

resource "aws_route53_record" "stag_wordpress" {
  zone_id         = aws_route53_zone.main.id
  name            = "blog-staging.fiardika.xyz"
  type            = "CNAME"
  ttl             = 60
  allow_overwrite = true
  records         = ["ad464fb41a51346c6b87e5192017153c-bfa250d72cfa6fdd.elb.ap-southeast-1.amazonaws.com"]
}

resource "aws_route53_record" "efk" {
  zone_id         = aws_route53_zone.main.id
  name            = "efk.fiardika.xyz"
  type            = "CNAME"
  ttl             = 60
  allow_overwrite = true
  records         = ["ad464fb41a51346c6b87e5192017153c-bfa250d72cfa6fdd.elb.ap-southeast-1.amazonaws.com"]
}

resource "aws_route53_record" "prometheus" {
  zone_id         = aws_route53_zone.main.id
  name            = "prometheus.fiardika.xyz"
  type            = "CNAME"
  ttl             = 60
  allow_overwrite = true
  records         = ["ad464fb41a51346c6b87e5192017153c-bfa250d72cfa6fdd.elb.ap-southeast-1.amazonaws.com"]
}

resource "aws_route53_record" "grafana" {
  zone_id         = aws_route53_zone.main.id
  name            = "grafana.fiardika.xyz"
  type            = "CNAME"
  ttl             = 60
  allow_overwrite = true
  records         = ["ad464fb41a51346c6b87e5192017153c-bfa250d72cfa6fdd.elb.ap-southeast-1.amazonaws.com"]
}

resource "aws_route53_record" "dashboard" {
  zone_id         = aws_route53_zone.main.id
  name            = "dash.fiardika.xyz"
  type            = "CNAME"
  ttl             = 60
  allow_overwrite = true
  records         = ["ad464fb41a51346c6b87e5192017153c-bfa250d72cfa6fdd.elb.ap-southeast-1.amazonaws.com"]
}