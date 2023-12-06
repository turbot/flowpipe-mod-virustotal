pipeline "get_ip_address_report" {
  title       = "Get IP Address Report"
  description = "Get information about an IP address."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "ip_address" {
    type        = string
    description = "The IP address to be scanned."
  }

  step "http" "get_ip_address_report" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/ip_addresses/${param.ip_address}"

    request_headers = {
      x-apikey = credential.virustotal[param.cred].api_key
      Accept   = "application/json"
    }
  }

  output "ip_report" {
    description = "The IP address report."
    value       = step.http.get_ip_address_report.response_body
  }
}
