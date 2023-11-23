pipeline "get_url_analysis" {
  title       = "Get URL Analysis"
  description = "Get a URL analysis report."

  param "api_key" {
    type        = string
    description = local.api_key_param_description
    default     = var.api_key
  }

  param "url" {
    type        = string
    description = "The url to be scanned."
  }

  step "http" "url_analysis" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/urls/${base64encode(param.url)}"

    request_headers = {
      x-apikey = param.api_key
      Accept   = "application/json"
    }
  }

  output "url_analysis" {
    description = "The URL analysis report."
    value       = step.http.url_analysis.response_body
  }
}
