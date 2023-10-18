// HTTP (Webhook) Trigger
trigger "http" "webhook_events" {
  description = "Instant trigger that looks for events related to GitHub Issue and takes necessary action."
  pipeline = pipeline.router_pipeline
  args = {
    request_body = self.request_body
    full_event        = join(".", [self.request_headers["X-Github-Event"], jsondecode(self.request_body).action]) // issue_comment.created or edited
    event  = self.request_headers["X-Github-Event"] // issue_comment
    action = jsondecode(self.request_body).action // created or edited
  }
}

pipeline "router_pipeline" {
  description = "Triggers are light weight and do not support conditions. Using an additional Router Pipeline to customize the actions."

  param "event" {
    type = string
  }

  param "action" {
    type = string
  }

  param "request_body" {
    type = string
  }

  step "container" "filter_url" {
    if       = contains(["issue_comment"], param.event)
    image = "alpine"
      cmd = ["sh", "-c", "echo -e \"${jsondecode(param.request_body).comment.body}\" | egrep -o 'http[s]?://\\S+|ftp://\\S+' | tr -d '\n'"]
  }

    step "pipeline" "scan_url" {
    if = step.container.filter_url.stdout != ""
    pipeline = pipeline.scan_url
    args = {
      url = "${step.container.filter_url.stdout}"
    }
  }

  step "pipeline" "slack_notification" {
    if = step.container.filter_url.stdout != "" && step.pipeline.scan_url.positives > 0
    pipeline = slack.pipeline.chat_post_message
    args = {
      message       = "User: ${jsondecode(param.request_body).comment.user.login} \nCommented on Issue: ${jsondecode(param.request_body).comment.html_url} \nMalicious URL Scan : ${step.container.filter_url.stdout} \nPositivies found: ${step.pipeline.scan_url.positives}"
    }
  }

}