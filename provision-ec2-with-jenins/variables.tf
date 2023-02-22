variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Current Region"
}

variable "access_key" {
  type        = string
  default     = "AKIA5MSSCG4OXHUZW2MN"
  description = "Access Key"
}

variable "secret_key" {
  type        = string
  default     = "x+WY6Y8XA1VDU9JHhEba2tgOl1Li0XveNF4HS5RL"
  description = "Secret Access Key"
}

variable "port_list" {
  description = "List of Port to open for Web Server"
  type        = list(any)
  default     = ["80", "8000", "8080"]
}

variable "instance_size" {
  description = "EC2 Instance Size"
  type        = string
  default     = "t2.medium"
}

variable "tags" {
  description = "Tags to Apply to Resources"
  type        = map(any)
  default = {
    Owner       = "Mustofa Kodir"
    Environment = "Prod"
    Project     = "Phoenix"
  }
}

variable "key_name" {
  description = "Jenkins Server Private Key"
  type        = string
  default     = "ec2-jenkins.pem"
}