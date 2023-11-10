pipeline "get_file_execution_parents" {
  title       = "Get File Execution Parents"
  description = "Gets the execution parents for a file from VirusTotal."

  param "api_key" {
    type        = string
    default     = var.api_key
    description = local.api_key_param_description
  }

  param "file_hash" {
    type        = string
    description = local.file_hash_param_description
  }

  step "http" "get_file_execution_parents" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/files/${param.file_hash}/execution_parents"

    request_headers = {
      x-apikey = param.api_key
      Accept   = "application/json"
    }
  }

  output "execution_parents" {
    description = "The execution parents for the file."
    value       = step.http.get_file_execution_parents.response_body
  }
}
