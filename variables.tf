variable "namespace" {
  type        = string
  description = "The namespace that Cert-Manager will reside in."
  default     = "cert-manager"
}
variable "namespace_annotations" {
  type        = map(string)
  description = "Additional namespace annotations."
  default     = {}
}
variable "image_repository" {
  type        = string
  description = "The image repository to use when pulling images"
  default     = null
}
variable "image_pull_policy" {
  type        = string
  description = "Determines when the image should be pulled prior to starting the container. `Always`: Always pull the image. | `IfNotPresent`: Only pull the image if it does not already exist on the node. | `Never`: Never pull the image"
  default     = "Always"
}
variable "labels" {
  type        = map(string)
  description = "(optional) A map that consists of any additional labels that should be included with resources created by this module."
  default     = {}
}
variable "certificate_issuers" {
  type = object({
    letsencrypt = object({
      name : string,
      server : string,
      email : string,
      secret_base64_key : string,
      solvers : object({
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
    })
    # The Vault issuer would go here.
    # test
    # A self-signed issuer could go here.
  })
  description = "An object that contains the configuration for all the enabled certificate issuers."
  default = {
    letsencrypt = null
  }
}
