pipeline "get_file_analysis" {
  title       = "Get File Analysis"
  description = "Gets analysis information about a file from VirusTotal."

  param "api_key" {
    type        = string
    default     = var.api_key
    description = "API key for authenticating requests with VirusTotal."
  }

  param "file_hash" {
    type        = string
    description = "The hash of the file to get analysis information for."
  }

  step "http" "get_file_analysis" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/files/${param.file_hash}"

    request_headers = {
      x-apikey = param.api_key
      Accept   = "application/json"
    }
  }

  output "file_information" {
    description = "Analysis information about the file."
    value       = step.http.get_file_analysis.response_body
  }
}
