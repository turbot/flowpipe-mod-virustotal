// Free API returns a 403 Forbidden error for file uploads and scans.
// Usage: Free: Must not be used in business workflows, commercial products or services.

// pipeline "scan_file" {
//   title       = "Submit a File for scanning"
//   description = "Submit a File for scanning by VirusTotal."

//   param "api_key" {
//     type        = string
//     description = "VirusTotal API key"
//     default     = var.api_key
//   }

//   param "slack_token" {
//     type    = string
//     description = "Slack app token used to connect to the API."
//     default = var.slack_token
//   }

//   param "slack_channel" {
//     type        = string
//     description = "Channel containing the message to be updated."
//     default     = var.slack_channel
//   }

//   // param "file" {
//   //   optional = true
//   //   type        = string
//   //   description = "File to scan"
//   //   default     = var.file
//   // }

//   param "file_path" {
//   type        = string
//   description = "Path to the file to upload"
//   default     = var.file_path
// }

//   step "http" "scan_file" {
//     title              = "Scan file"
//     description        = "Submit a file to VirusTotal for scanning."
//     url                = "https://www.virustotal.com/api/v3/files"
//     method             = "POST"
//     request_timeout_ms = 20000
//     request_headers    = {
//       "x-apikey" = var.api_key
//     }
//     request_body = jsonencode({
//       file = file(var.file_path)
//     })
//   }

//   step "pipeline" "post_message" {
//   pipeline = slack.pipeline.chat_post_message
//   args = {
//     message = (jsondecode(step.http.scan_file.response_body).positives > 0
//       ? "OOPS!! There are ${jsondecode(step.http.scan_file.response_body).positives} suspicious links in the file!"
//       : "Happy days")
//     }
//   }

//   output "positives" {
//     value = jsondecode(step.http.scan_file.response_body).positives
//   }
//   output "response_body" {
//     value = step.http.scan_file.response_body
//   }
//   output "analysis_id" {
//   value = jsondecode(step.http.scan_file.response_body).data.id
//   }
// }