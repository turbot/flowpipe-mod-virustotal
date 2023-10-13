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
    default     = var.url
  }

  step "http" "scan_url" {
    title              = "Scan url"
    description        = "Submit a URL to VirusTotal for scanning."
    # curl --request POST \
    #  --url https://www.virustotal.com/api/v3/urls \
    #  --form url=<Your URL here>
    #  --header 'x-apikey: <your API key>'
    url                = "https://www.virustotal.com/api/v3/urls?url=${urlencode("${param.url}")}"
    method             = "post"
    request_timeout_ms = 20000
    request_headers    = {
      x-apikey = "${var.api_key}"
    }
  }

  output "status_code" {
    value = step.http.scan_url.status_code
  }
  output "analysis_id" {
    value = jsondecode(step.http.scan_url.response_body).data.id
  }
}