pipeline "get_file_behaviour_summary" {
  title       = "Get File Behaviour Summary"
  description = "Gets the behaviour summary for a file from VirusTotal."

  param "api_key" {
    type        = string
    default     = var.api_key
    description = local.api_key_param_description
  }

  param "file_hash" {
    type        = string
    description = local.file_hash_param_description
  }

  step "http" "get_file_behaviour_summary" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/files/${param.file_hash}/behaviour_summary"

    request_headers = {
      x-apikey = param.api_key
      Accept   = "application/json"
    }
  }

  output "behaviour_summary" {
    description = "The behaviour summary for the file."
    value       = step.http.get_file_behaviour_summary.response_body
  }
}
