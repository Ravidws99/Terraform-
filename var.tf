variable "instance_count" {
  type    = number
  default = 2
}

variable "ami_id" {
  type    = string
  default = "ami-0d0175e9dbb94e0d2"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}
