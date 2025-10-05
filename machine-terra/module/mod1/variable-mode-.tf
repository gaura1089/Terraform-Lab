variable "image_name" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "tag_name" {
   type = string

}

variable "key_name" {
   type = string
}

variable "pub-key" {
   type = string

}

variable "security-group" {
  type = list(string)
  # default = aws_security_group.SG11

}

variable "location" {
  type= string
}



# variable "network" {
#   type= string
# }


