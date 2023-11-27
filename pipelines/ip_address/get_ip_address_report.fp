pipeline "get_ip_address_report" {
  title       = "Get IP Address Report"
  description = "Get information about an IP address."

  param "api_key" {
    type        = string
    default     = var.api_key
    description = local.api_key_param_description
  }

  param "ip_address" {
    type        = string
    description = "The IP address to be scanned."
  }

  step "http" "get_ip_address_report" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/ip_addresses/${param.ip_address}"

    request_headers = {
      x-apikey = param.api_key
      Accept   = "application/json"
    }
  }

  output "ip_report" {
    description = "The IP address report."
    value       = step.http.get_ip_address_report.response_body
  }
}
