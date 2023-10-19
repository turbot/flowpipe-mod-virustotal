// HTTP (Webhook) Trigger
trigger "http" "webhook_events" {
  description = "Instant trigger that looks for events related to GitHub Issue and takes necessary action."
  pipeline = pipeline.router_pipeline
  args = {
    request_body = self.request_body
    full_event        = join(".", [self.request_headers["X-Github-Event"], jsondecode(self.request_body).action]) // issue_comment.created or edited
    event  = self.request_headers["X-Github-Event"] // issue_comment
    action = jsondecode(self.request_body).action // created or edited
    issue_comment_id = jsondecode(self.request_body).comment.node_id //comment id
  }
}

pipeline "router_pipeline" {
  description = "Triggers are light weight and do not support conditions. Using an additional Router Pipeline to customize the actions."

  param "full_event" {
    type = string
  }

  param "action" {
    type = string
  }

  param "request_body" {
    type = string
  }

  param "issue_comment_id" {
    type = string
  }

  param "issue_comment"{
    type = string
  }

  step "container" "filter_url" {
    if = contains(["issue_comment.created", "issue_comment.edited"], param.full_event)
    image = "alpine"
        cmd = ["sh", "-c", "urls=$(echo -e \"${jsondecode(param.request_body).comment.body}\" | egrep -o 'http[s]?://\\S+|ftp://\\S+' | head -n 1 | sed 's/)//g'); if [ -n \"$urls\" ]; then echo -n \"$urls\"; fi"]
  }

  step "pipeline" "scan_url" {
    if =  step.container.filter_url.stdout != ""
    pipeline = pipeline.scan_url
    args = {
      url = "${step.container.filter_url.stdout}"
    }
  }

  // if positives is > 0 then remove the url and add the removed by Turbot flag and update the same comment with the updated text.

    step "container" "remove_url" {
    if = step.pipeline.scan_url.positives > 0
    image = "alpine"
        cmd = ["sh", "-c", "echo -e \"${jsondecode(param.request_body).comment.body}\" | sed -E 's@(http[s]?://\\S+|ftp://\\S+)@**Malicious url removed by e-Jasoos**@g; s@\\(\\*\\*Malicious url removed by e-Jasoos\\*\\*@(**Malicious url removed by e-Jasoos**)@g'"]
  }

  step "pipeline" "update_comment" {
    depends_on = [step.container.remove_url]
    pipeline = github.pipeline.issue_update_comment
    args = {
      issue_comment_id = "${param.issue_comment_id}"
      issue_comment = "${step.container.remove_url.stdout}"
    }
  }

  // step "pipeline" "delete_comment" {
  //   if = step.pipeline.scan_url.positives > 0
  //   pipeline = github.pipeline.issue_delete_comment
  //   args = {
  //     issue_comment_id = "${param.issue_comment_id}"
  //   }
  // }

  step "pipeline" "slack_notification" {
    if =  step.container.remove_url.stdout != "" && step.pipeline.scan_url.positives > 0
    pipeline = slack.pipeline.chat_post_message
    args = {
      message       = "User: ${jsondecode(param.request_body).comment.user.login} \nCommented on Issue: ${jsondecode(param.request_body).comment.html_url} \nMalicious URL Scan : ${step.container.filter_url.stdout} \nPositivies found: ${step.pipeline.scan_url.positives} \n Now Updated"
    }
  }

}