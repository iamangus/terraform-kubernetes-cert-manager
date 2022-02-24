variable "name" {
  type    = string
  default = "cert-manager"
}
variable "instance_id" {
  type = string
}
variable "component" {
  type    = string
  default = "controller"
}
variable "namespace" {
  type = string
}
variable "image_tag" {
  type    = string
  default = "v1.4.0" #"v0.13.0"
}
variable "image_name" {
  type    = string
  default = "jetstack/cert-manager-controller"
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
