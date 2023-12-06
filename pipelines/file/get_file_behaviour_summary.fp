pipeline "get_file_behaviour_summary" {
  title       = "Get File Behaviour Summary"
  description = "Gets the behaviour summary for a file from VirusTotal."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "file_hash" {
    type        = string
    description = local.file_hash_param_description
  }

  step "http" "get_file_behaviour_summary" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/files/${param.file_hash}/behaviour_summary"

    request_headers = {
      x-apikey = credential.virustotal[param.cred].api_key
      Accept   = "application/json"
    }
  }

  output "behaviour_summary" {
    description = "The behaviour summary for the file."
    value       = step.http.get_file_behaviour_summary.response_body
  }
}
