variable "api_key" {
  type = string
  description = "VirusTotal API Key"
}

variable "url" {
  type = string
  description = "A URL for VirusTotal to scan"
  default = ""
}

variable "slack_token" {
  type = string
  description = "A URL for VirusTotal to scan"
}

variable "slack_channel" {
  type = string
  description = "A URL for VirusTotal to scan"
}

variable "file_path" {
  type = string
}

variable "github_repository_full_name"{
  type = string
}

variable "github_token"{
  type = string
}