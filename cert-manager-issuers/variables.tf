variable "namespace" {
  type = string
}
variable "letsencrypt" {
  type = object({
    name : string,
    server : string,
    email : string,
    secret_base64_key : string,
    solvers : object({
      http01 : optional(object({
        default_issuer : bool,
        ingress_class : string
      })),
      dns01 : object({
        cloudflare : optional(object({
          default_issuer : bool,
          email : string,
          base64_api_key : string
        })),
        digitalocean : optional(object({
          default_issuer : bool,
          base64_access_token : string
        }))
      })
    })
  })
  default = null
}