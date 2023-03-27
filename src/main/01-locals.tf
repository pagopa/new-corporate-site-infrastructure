locals {
  project = format("%s-%s", var.app_name, var.env_short)

  strapi_container_port = 1337

  apprunner_service_name = "cms-strapi"

  apprunners_loggroups = [
    join("/", ["/aws/apprunner", local.apprunner_service_name, module.app-runner.service_id, "application"]),
    join("/", ["/aws/apprunner", local.apprunner_service_name, module.app-runner.service_id, "service"]),
  ]

  cname_cms     = "cms"
  cname_preview = "preview"

  fe_github_repository = format("https://github.com/%s", var.fe_github_repository)

}