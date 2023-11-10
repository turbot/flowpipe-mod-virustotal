# TODO: Remove all defaults once variables can be passed to mod dependencies properly

variable "api_key" {
  type        = string
  description = "API key for authenticating requests with VirusTotal."
  default     = ""
}
