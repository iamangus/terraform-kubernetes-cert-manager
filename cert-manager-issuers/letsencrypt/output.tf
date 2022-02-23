locals {
  for solver in local.solvers:
    tempIss = solver.value ? each.key : 0
}

output "default_issuer" {
  value = local.tempIss
}