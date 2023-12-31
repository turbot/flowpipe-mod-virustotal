pipeline "get_file_graphs" {
  title       = "Get File Graphs"
  description = "Gets the graphs for a file from VirusTotal."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "file_hash" {
    type        = string
    description = local.file_hash_param_description
  }

  step "http" "get_file_graphs" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/files/${param.file_hash}/graphs"

    request_headers = {
      x-apikey = credential.virustotal[param.cred].api_key
      Accept   = "application/json"
    }
  }

  output "graphs" {
    description = "The graphs for the file."
    value       = step.http.get_file_graphs.response_body
  }
}
