pipeline "get_file_behaviours" {
  title       = "Get File Behaviours"
  description = "Gets all the behaviours for a file from VirusTotal."

  param "conn" {
    type        = connection.virustotal
    description = local.conn_param_description
    default     = connection.virustotal.default
  }

  param "file_hash" {
    type        = string
    description = local.file_hash_param_description
  }

  step "http" "get_file_behaviours" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/files/${param.file_hash}/behaviours"

    request_headers = {
      x-apikey = param.conn.api_key
      Accept   = "application/json"
    }
  }

  output "behaviours" {
    description = "The behaviours for the file."
    value       = step.http.get_file_behaviours.response_body
  }
}
