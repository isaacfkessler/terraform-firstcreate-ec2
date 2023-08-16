variable "aws_region" {
  type        = string
  description = "Definir regiao para a AWS"
  default     = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = "Definir qual perfil será utilizado"
  default     = "default"
}
