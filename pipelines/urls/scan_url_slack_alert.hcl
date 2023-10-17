pipeline "scan_url" {
  title       = "Submit a URL for scanning"
  description = "Submit a URL for scanning by VirusTotal."

  param "api_key" {
    type        = string
    description = "VirusTotal API key"
    default     = var.api_key
  }

  param "slack_token" {
    type    = string
    description = "Slack app token used to connect to the API."
    default = var.slack_token
  }

  param "slack_channel" {
    type        = string
    description = "Channel containing the message to be updated."
    default     = var.slack_channel
  }

  param "url" {
    optional = true
    type        = string
    description = "URL to scan"
    default     = var.url
  }

  step "http" "scan_url" {
    title              = "Scan url"
    description        = "Submit a URL to VirusTotal for scanning."
    url                = "https://www.virustotal.com/vtapi/v2/url/report?apikey=${var.api_key}&resource=${urlencode(var.url)}"
    method             = "GET"
    request_timeout_ms = 20000
  }

  step "pipeline" "post_message" {
  pipeline = slack.pipeline.chat_post_message
  args = {
    message = (jsondecode(step.http.scan_url.response_body).positives > 0
      ? "OOPS!! There are ${jsondecode(step.http.scan_url.response_body).positives} suspicious links in the file!"
      : "Happy days")
    }
  }

  output "positives" {
    value = jsondecode(step.http.scan_url.response_body).positives
  }

  output "response_body" {
    value = step.http.scan_url.response_body
  }
  output "analysis_id" {
  value = jsondecode(step.http.scan_url.response_body).data.id
  }
}