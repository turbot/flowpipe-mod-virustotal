pipeline "get_file_pe_resource_children" {
  title       = "Get File PE Resource Children"
  description = "Gets the PE resource children for a file."

  param "api_key" {
    type        = string
    default     = var.api_key
    description = "API key for authenticating requests with VirusTotal."
  }

  param "file_hash" {
    type        = string
    description = "The hash of the file to get the PE resource children for."
  }

  step "http" "get_file_pe_resource_children" {
    method = "get"
    url    = "https://www.virustotal.com/api/v3/files/${param.file_hash}/pe_resource_children"

    request_headers = {
      x-apikey = param.api_key
      Accept   = "application/json"
    }
  }

  output "pe_resource_children" {
    description = "The PE resource children for the file."
    value       = step.http.get_file_pe_resource_children.response_body
  }
}
