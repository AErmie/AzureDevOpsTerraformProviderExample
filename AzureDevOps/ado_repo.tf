resource "azuredevops_git_repository" "new_repo" {
  project_id = azuredevops_project.adoproj.id
  name       = "ADO Native Repo"
  initialization {
    init_type = "Clean" #Options: Uninitialized, Clean, or Import
  }
}

# NOTE: 'Import' does not support importing a private git repo (one that requires authentication).
# This may not yet be supported (ie. to import a repo)
resource "azuredevops_git_repository" "existing_repo" {
  project_id = azuredevops_project.adoproj.id
  name       = "My Awesome Repo"
  initialization {
    init_type = "Import" #Options: Uninitialized, Clean, or Import
    source_type = "Git" # Type type of the source repository. Used if the init_type is Import.
    source_url = "https://github.com/<URL>" # The URL of the source repository. Used if the init_type is Import.
  }
}