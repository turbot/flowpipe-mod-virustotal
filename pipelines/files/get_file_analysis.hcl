pipeline "get_file_analysis" {
  title       = "Get File Analysis"
  description = "Gets analysis about a file from VirusTotal."

  param "api_key" {
    type        = string
    default     = var.api_key
    description = local.api_key_param_description
  }

  param "file_hash" {
    type        = string
    description = local.file_hash_param_description
  }

  step "http" "get_file_analysis" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/files/${param.file_hash}"

    request_headers = {
      x-apikey = param.api_key
      Accept   = "application/json"
    }
  }

  output "file_analysis" {
    description = "Analysis about the file."
    value       = step.http.get_file_analysis.response_body
  }
}
