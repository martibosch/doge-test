## Staging/production deployment

### First-time setup

#### 1. Initialize terraform

From the `terraform` directory, initalize terraform with the following command, which should only be run once (unless the provider/module versions change):

```bash
cd terraform
terraform init
```

and when asked to choose a workspace name for terraform cloud, provide `doge-test`.

#### 2. Create GitHub token and add it to terraform cloud

[Create a GitHub token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)

"Variables" tab, "Add variable", select "Environment variable", with `GITHUB_TOKEN` as key and the token as value.


#### 3. Provision empty GitHub repository with terraform

TODO: do var files work with terraform cloud?

```bash
terraform plan -target=module.base.github_repository.repo -var-file=staging.tfvars
```

```bash
terraform apply -target=module.base.github_repository.repo -var-file=staging.tfvars
```


#### 4. Push first commit

Initialize a git repository **from the root directory**

```bash
cd ..  # if you come from the `terraform` directory from the steps above
git init
git remote add origin git@github.com:<user-or-organization>/<repo-name>.git
git push  $ optionally use `--force-with-lease` if needed
```

#### 5. Provision the rest of the infrastructure

Plan the changes:

```bash
terraform plan -var-file=staging.tfvars
```

review them, and apply:

```bash
terraform apply -var-file=staging.tfvars
```

### Deployment

The actual deployment strategy follows a git-ops workflow.
