pipeline "get_file_execution_parents" {
  title       = "Get File Execution Parents"
  description = "Gets the execution parents for a file from VirusTotal."

  param "api_key" {
    type        = string
    default     = var.api_key
    description = "API key for authenticating requests with VirusTotal."
  }

  param "file_hash" {
    type        = string
    description = "The hash of the file to get execution parents for."
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
