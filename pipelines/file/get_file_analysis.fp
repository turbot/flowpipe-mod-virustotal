pipeline "get_file_analysis" {
  title       = "Get File Analysis"
  description = "Gets analysis about a file from VirusTotal."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "file_hash" {
    type        = string
    description = local.file_hash_param_description
  }

  step "http" "get_file_analysis" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/files/${param.file_hash}"

    request_headers = {
      x-apikey = credential.virustotal[param.cred].api_key
      Accept   = "application/json"
    }
  }

  output "file_analysis" {
    description = "Analysis about the file."
    value       = step.http.get_file_analysis.response_body
  }
}
