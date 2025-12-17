

variable "ami" {
  type    = string
  default = "ami-020cba7c55df1f615"
}

variable "instancetype" {
  type    = string
  default = "t2.micro"
}

variable "instancecount" {
  type    = number
  default = 2
}

