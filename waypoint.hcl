project = "hello-k8s"

app "hello-k8s" {
  labels = {
      "service" = "hello-k8s",
      "env" = "dev"
  }

  build {
    use "pack" {}
    registry {
        use "docker" {
          image = "hello-k8s"
          tag = "latest"
          local = true
        }
    }
 }

  deploy { 
    use "kubernetes" {
    probe_path = "/"
    }
  }

  release {
    use "kubernetes" {
    }
  }
}
