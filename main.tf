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




