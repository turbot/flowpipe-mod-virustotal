variable "api_key" {
  type = string
  description = "VirusTotal API Key"
  default = ""
}

variable "url" {
  type = string
  description = "A URL for VirusTotal to scan"
  default = ""
}