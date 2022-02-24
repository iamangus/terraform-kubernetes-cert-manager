variable "name" {
  type    = string
  default = "cert-manager-cainjector"
}
variable "instance_id" {
  type = string
}
variable "component" {
  type    = string
  default = "cainjector"
}
variable "namespace" {
  type = string
}
variable "image_tag" {
  type    = string
  default = "v1.7.1" #"v0.13.0"
}
variable "image_name" {
  type    = string
  default = "jetstack/cert-manager-cainjector"
}
variable "image_repository" {
  type = string
}
variable "image_pull_policy" {
  type = string
}
variable "labels" {
  type = map(string)
}
