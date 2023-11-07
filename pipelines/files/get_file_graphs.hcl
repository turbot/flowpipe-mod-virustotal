pipeline "get_file_graphs" {
  title       = "Get File Graphs"
  description = "Gets the graphs for a file from VirusTotal."

  param "api_key" {
    type        = string
    default     = var.api_key
    description = "API key for authenticating requests with VirusTotal."
  }

  param "file_hash" {
    type        = string
    description = "The hash of the file to get graphs for."
  }

  step "http" "get_file_graphs" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/files/${param.file_hash}/graphs"

    request_headers = {
      x-apikey = param.api_key
      Accept   = "application/json"
    }
  }

  output "graphs" {
    description = "The graphs for the file."
    value       = step.http.get_file_graphs.response_body
  }
}
