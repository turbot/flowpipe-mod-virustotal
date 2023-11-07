pipeline "get_file_comments" {
  title       = "Get File Comments"
  description = "Gets the comments for a file from VirusTotal."

  param "api_key" {
    type        = string
    default     = var.api_key
    description = local.api_key_param_description
  }

  param "file_hash" {
    type        = string
    description = "The hash of the file to get comments for."
  }

  step "http" "get_file_comments" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/files/${param.file_hash}/comments"

    request_headers = {
      x-apikey = param.api_key
      Accept   = "application/json"
    }
  }

  output "comments" {
    description = "The comments for the file."
    value       = step.http.get_file_comments.response_body
  }
}
