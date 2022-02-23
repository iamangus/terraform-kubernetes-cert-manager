variable "name" {
  type = string
}
variable "namespace" {
  type = string
}
variable "server" {
  type = string
}
variable "email" {
  type = string
}
variable "secret_base64_key" {
  type = string
}
variable "solvers" {
  type = object({
    http01 : optional(object({
      default_issuer : bool,
      ingress_class : string
    })),
    dns01 : optional(object({
      cloudflare : optional(object({
        default_issuer : bool,
        email : string,
        base64_api_key : string
      })),
      digitalocean : optional(object({
        default_issuer : bool,
        base64_access_token : string
      }))
    }))
  })
}
