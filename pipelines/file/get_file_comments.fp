pipeline "get_file_comments" {
  title       = "Get File Comments"
  description = "Gets the comments for a file from VirusTotal."

  param "conn" {
    type        = connection.virus_total
    description = local.conn_param_description
    default     = connection.virus_total.default
  }

  param "file_hash" {
    type        = string
    description = local.file_hash_param_description
  }

  step "http" "get_file_comments" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/files/${param.file_hash}/comments"

    request_headers = {
      x-apikey = param.conn.api_key
      Accept   = "application/json"
    }
  }

  output "comments" {
    description = "The comments for the file."
    value       = step.http.get_file_comments.response_body
  }
}
