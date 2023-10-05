provider "google" {
  project     = "devops-tp2"
  region      = "us-central1"
}

# resource "google_project_service" "api-resourcemanager" {
#   service = "cloudresourcemanager.googleapis.com"
# }

resource "google_project_service" "artifact" {
    project = "devops-tp2"
  service = "artifactregistry.googleapis.com"
}

resource "google_project_service" "serviceusage" {
        project = "devops-tp2"
  service = "serviceusage.googleapis.com"
}


resource "google_project_service" "sqladmin" {
        project = "devops-tp2"
  service = "sqladmin.googleapis.com"
}

resource "google_project_service" "cloudbuild" {
        project = "devops-tp2"
  service = "cloudbuild.googleapis.com"
}

resource "google_project_service" "resourcemanager" {
        project = "devops-tp2"
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "cloudrun" {
        project = "devops-tp2"
  service = "run.googleapis.com"
}

resource "google_artifact_registry_repository" "artifact" {
  repository_id = "website-tool"
  format = "DOCKER"
  location = "us-central1"

}

resource "google_sql_user" "wordpress" {
   name     = "wordpress"
   instance = "main-instance"
   password = "ilovedevops"
}

resource "google_cloud_run_service" "default" {
name     = "serveur-wordpress"
location = "us-central1"

template {
   spec {
      containers {
      image = "us-central1-docker.pkg.dev/devops-tp2/website-tool/wordpressimag"
      ports {
          container_port = 80
        }
      }
   }

   metadata {
      annotations = {
            "run.googleapis.com/cloudsql-instances" = "devops-tp2:us-central1:main-instance"
      }
   }
}

traffic {
   percent         = 100
   latest_revision = true
}
}

data "google_iam_policy" "noauth" {
   binding {
      role = "roles/run.invoker"
      members = [
         "allUsers",
      ]
   }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
   location    = google_cloud_run_service.default.location
   project     = google_cloud_run_service.default.project
   service     = google_cloud_run_service.default.name

   policy_data = data.google_iam_policy.noauth.policy_data
}

