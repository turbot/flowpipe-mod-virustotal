pipeline "get_ip" {
  title       = "Get IP Address"
  description = "Get information about an IP Address."

  param "api_key" {
    type        = string
    default     = var.api_key
    description = "API key for authenticating requests with VirusTotal."
  }

  param "ip_address" {
    type        = string
    description = "The IP address that needs to be scanned."
  }

  step "http" "get_ip" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/ip_addresses/${param.ip_address}"

    request_headers = {
      x-apikey = param.api_key
      Accept   = "application/json"
    }
  }

  output "ip_report" {
    description = "The result of submitting the URL for scanning."
    value       = step.http.get_ip.response_body
  }
}
