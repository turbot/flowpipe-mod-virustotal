pipeline "get_domain_report" {
  title       = "Get Domain Report"
  description = "Get information about a Domain."

  param "api_key" {
    type        = string
    description = local.api_key_param_description
    default     = var.api_key
  }

  param "domain" {
    type        = string
    description = "The domain to be scanned."
  }

  step "http" "get_domain_report" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/domains/${param.domain}"

    request_headers = {
      x-apikey = param.api_key
      Accept   = "application/json"
    }
  }

  output "domain_report" {
    description = "The domain report."
    value       = step.http.get_domain_report.response_body
  }
}
