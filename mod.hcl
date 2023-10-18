mod "virustotal" {
  title         = "VirusTotal"
  description   = "Run pipelines and triggers that interact with VirusTotal."
  color         = "#191717"
  documentation = file("./docs/index.md")
  icon          = "/images/flowpipe/mods/turbot/virustotal.svg"
  categories    = ["virustotal","security"]

  opengraph {
    title       = "VirusTotal"
    description = "Run pipelines and triggers that interact with VirusTotal."
    image       = "/images/flowpipe/mods/turbot/virustotal-social-graphic.png"
  }

  require {

    mod "github.com/turbot/flowpipe-mod-slack" {
      version = "*"
      args = {
        token   = var.slack_token
        channel = var.slack_channel
      }
    }

    mod "github.com/turbot/flowpipe-mod-github" {
      version = "*"
      args = {
        repository_full_name = var.github_repository_full_name
        token                = var.github_token
      }
    }
  }
}