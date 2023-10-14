variable "api_key" {
  type = string
  description = "VirusTotal API Key"
}

variable "url" {
  type = string
  description = "A URL for VirusTotal to scan"
}

variable "file" {
  description = "Path to the local file"
  type        = string
}