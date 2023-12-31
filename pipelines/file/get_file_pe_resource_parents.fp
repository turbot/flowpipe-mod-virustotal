pipeline "get_file_pe_resource_parents" {
  title       = "Get File PE Resource Parents"
  description = "Gets the PE resource parents for a file."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "file_hash" {
    type        = string
    description = local.file_hash_param_description
  }

  step "http" "get_file_pe_resource_parents" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/files/${param.file_hash}/pe_resource_parents"

    request_headers = {
      x-apikey = credential.virustotal[param.cred].api_key
      Accept   = "application/json"
    }
  }

  output "pe_resource_parents" {
    description = "The PE resource parents for the file."
    value       = step.http.get_file_pe_resource_parents.response_body
  }
}
