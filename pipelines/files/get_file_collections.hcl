pipeline "get_file_collections" {
  title       = "Get File Collections"
  description = "Gets the collections for a file from VirusTotal."

  param "api_key" {
    type        = string
    default     = var.api_key
    description = "API key for authenticating requests with VirusTotal."
  }

  param "file_hash" {
    type        = string
    description = "The hash of the file to get collections for."
  }

  step "http" "get_file_collections" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/files/${param.file_hash}/collections"

    request_headers = {
      x-apikey = param.api_key
      Accept   = "application/json"
    }
  }

  output "collections" {
    description = "The collections for the file."
    value       = step.http.get_file_collections.response_body
  }
}
