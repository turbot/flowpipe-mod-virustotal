pipeline "scan_url" {
  title       = "Submit a URL for scanning"
  description = "Submit a URL for scanning by VirusTotal."

  param "api_key" {
    type        = string
    description = "VirusTotal API key"
    default     = var.api_key
  }

  param "url" {
    type        = string
    description = "URL to scan"
  }

  step "http" "scan_url" {
    title              = "Scan url"
    description        = "Submit a URL to VirusTotal for scanning."
    url                = "https://www.virustotal.com/vtapi/v2/url/report?apikey=${param.api_key}&resource=${urlencode(param.url)}"
    method             = "GET"
    request_timeout_ms = 20000
  }

output "positives" {
    value = step.http.scan_url.response_body.positives
  }

}