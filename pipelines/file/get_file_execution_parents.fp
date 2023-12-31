pipeline "get_file_execution_parents" {
  title       = "Get File Execution Parents"
  description = "Gets the execution parents for a file from VirusTotal."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "file_hash" {
    type        = string
    description = local.file_hash_param_description
  }

  step "http" "get_file_execution_parents" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/files/${param.file_hash}/execution_parents"

    request_headers = {
      x-apikey = credential.virustotal[param.cred].api_key
      Accept   = "application/json"
    }
  }

  output "execution_parents" {
    description = "The execution parents for the file."
    value       = step.http.get_file_execution_parents.response_body
  }
}
