pipeline "get_file_behaviour_mitre_trees" {
  title       = "Get File Behaviour MITRE Trees"
  description = "Gets the behaviour MITRE trees for a file from VirusTotal."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "file_hash" {
    type        = string
    description = local.file_hash_param_description
  }

  step "http" "get_file_behaviour_mitre_trees" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/files/${param.file_hash}/behaviour_mitre_trees"

    request_headers = {
      x-apikey = credential.virustotal[param.cred].api_key
      Accept   = "application/json"
    }
  }

  output "behaviour_mitre_trees" {
    description = "The behaviour MITRE trees for the file."
    value       = step.http.get_file_behaviour_mitre_trees.response_body
  }
}
