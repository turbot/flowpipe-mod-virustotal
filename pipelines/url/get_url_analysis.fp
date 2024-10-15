pipeline "get_url_analysis" {
  title       = "Get URL Analysis"
  description = "Get a URL analysis report."

  param "conn" {
    type        = connection.virustotal
    description = local.conn_param_description
    default     = connection.virustotal.default
  }

  param "url" {
    type        = string
    description = "The url to be scanned."
  }

  step "http" "get_url_analysis" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/urls/${base64encode(param.url)}"

    request_headers = {
      x-apikey = param.conn.api_key
      Accept   = "application/json"
    }
  }

  output "url_analysis" {
    description = "The URL analysis report."
    value       = step.http.get_url_analysis.response_body
  }
}
