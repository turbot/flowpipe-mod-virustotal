pipeline "get_file_behaviour_mitre_trees" {
  title       = "Get File Behaviour MITRE Trees"
  description = "Gets the behaviour MITRE trees for a file from VirusTotal."

  param "api_key" {
    type        = string
    default     = var.api_key
    description = "API key for authenticating requests with VirusTotal."
  }

  param "file_hash" {
    type        = string
    description = "The hash of the file to get the behaviour MITRE trees for."
  }

  step "http" "get_file_behaviour_mitre_trees" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/files/${param.file_hash}/behaviour_mitre_trees"

    request_headers = {
      x-apikey = param.api_key
      Accept   = "application/json"
    }
  }

  output "behaviour_mitre_trees" {
    description = "The behaviour MITRE trees for the file."
    value       = step.http.get_file_behaviour_mitre_trees.response_body
  }
}
