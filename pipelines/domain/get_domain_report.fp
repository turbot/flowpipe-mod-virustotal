pipeline "get_domain_report" {
  title       = "Get Domain Report"
  description = "Get information about a Domain."

  tags = {
    recommended = "true"
  }

  param "conn" {
    type        = connection.virus_total
    description = local.conn_param_description
    default     = connection.virus_total.default
  }

  param "domain" {
    type        = string
    description = "The domain to be scanned."
  }

  step "http" "get_domain_report" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/domains/${param.domain}"

    request_headers = {
      x-apikey = param.conn.api_key
      Accept   = "application/json"
    }
  }

  output "domain_report" {
    description = "The domain report."
    value       = step.http.get_domain_report.response_body
  }
}
