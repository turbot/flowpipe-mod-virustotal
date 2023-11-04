pipeline "get_file_behaviours" {
  title       = "Get File Behaviours"
  description = "Gets all the behaviours for a file from VirusTotal."

  param "api_key" {
    type        = string
    default     = var.api_key
    description = "API key for authenticating requests with VirusTotal."
  }

  param "file_hash" {
    type        = string
    description = "The hash of the file to get the behaviour summary for."
  }

  step "http" "get_file_behaviours" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/files/${param.file_hash}/behaviours"

    request_headers = {
      x-apikey = param.api_key
      Accept   = "application/json"
    }
  }

  output "behaviour_summary" {
    description = "The behaviour summary for the file."
    value       = step.http.get_file_behaviours.response_body
  }
}
