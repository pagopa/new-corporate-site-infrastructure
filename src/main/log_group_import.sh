service_name="$(terraform output | grep app_runner_service_arn | awk -F\/ '{ print $2 }')"
service_id="$(terraform output | grep app_runner_service_id | awk -F\" '{ print $2 }')"

terraform output | grep app_runner_service_id | awk -F\" '{ print $2 }'

cat <<EOF > 46-apprunner_log_group.tf
resource "aws_cloudwatch_log_group" "service" {
  name = "/aws/apprunner/${service_name}/${service_id}/service"

  retention_in_days = var.log_group_policy_retention

}

resource "aws_cloudwatch_log_group" "application" {
  name = "/aws/apprunner/${service_name}/${service_id}/application"

  retention_in_days = var.log_group_policy_retention

}

variable "log_group_policy_retention" {
  type        = number
  description = "Retention days policy related to a log group app runner"
  default     = 30
}
EOF

./terraform.sh import dev  aws_cloudwatch_log_group.application "/aws/apprunner/${service_name}/${service_id}/application"
./terraform.sh import dev  aws_cloudwatch_log_group.service "/aws/apprunner/${service_name}/${service_id}/service"
