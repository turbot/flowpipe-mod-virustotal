pipeline "get_domain_report" {
  title       = "Get Domain Report"
  description = "Get information about a Domain."

  tags = {
    type = "featured"
  }
  
  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "domain" {
    type        = string
    description = "The domain to be scanned."
  }

  step "http" "get_domain_report" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/domains/${param.domain}"

    request_headers = {
      x-apikey = credential.virustotal[param.cred].api_key
      Accept   = "application/json"
    }
  }

  output "domain_report" {
    description = "The domain report."
    value       = step.http.get_domain_report.response_body
  }
}
