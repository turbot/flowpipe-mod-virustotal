pipeline "get_file_collections" {
  title       = "Get File Collections"
  description = "Gets the collections for a file from VirusTotal."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "file_hash" {
    type        = string
    description = local.file_hash_param_description
  }

  step "http" "get_file_collections" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/files/${param.file_hash}/collections"

    request_headers = {
      x-apikey = credential.virustotal[param.cred].api_key
      Accept   = "application/json"
    }
  }

  output "collections" {
    description = "The collections for the file."
    value       = step.http.get_file_collections.response_body
  }
}
