resource "azuredevops_project" "adoproj" {
  project_name       = "My ADO Project Name"
  description  = "What is this project about?"
  visibility         = "public" # Options: private, public
  version_control    = "Git" # Options: Git, Tfvc
  work_item_template = "Agile" # Options: Agile, Basic, CMMI, Scrum
  features = {
      "boards" = "enabled"
      "repositories" = "enabled"
      "pipelines" = "enabled"
      "testplans" = "enabled"
      "artifacts" = "enabled"
  }
}

#Either method (ie. inline or as a separate resource, will work)
resource "azuredevops_project_features" "my-project-features" {
  project_id = azuredevops_project.adoproj.id
  features = {
      "boards" = "enabled"
      "repositories" = "enabled"
      "pipelines" = "enabled"
      "testplans" = "enabled"
      "artifacts" = "enabled"
  }
}