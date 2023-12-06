pipeline "get_file_pe_resource_children" {
  title       = "Get File PE Resource Children"
  description = "Gets the PE resource children for a file."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "file_hash" {
    type        = string
    description = local.file_hash_param_description
  }

  step "http" "get_file_pe_resource_children" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/files/${param.file_hash}/pe_resource_children"

    request_headers = {
      x-apikey = credential.virustotal[param.cred].api_key
      Accept   = "application/json"
    }
  }

  output "pe_resource_children" {
    description = "The PE resource children for the file."
    value       = step.http.get_file_pe_resource_children.response_body
  }
}
