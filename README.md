## Staging/production deployment

### First-time setup

#### 1. Initialize terraform

```bash
make init-base
```

#### 2. Create github repository and import into terraform state

```bash
git init
git add .
git commit -m "initial commit"
gh repo create --public --source=. --push --remote=origin
terraform -chdir="./terraform/deploy/base" import -var-file=vars.tfvars module.base.github_repository.repo doge-test
```


#### 1. Initialize terraform

From the `terraform` directory, initalize terraform with the following command, which should only be run once (unless the provider/module versions change):

```bash
cd terraform
terraform init
```

#### 2. Setup secrets

##### 2.1 Create GitHub token and add it to Terraform Cloud

Create a GitHub token

"Variables" tab, "Add variable", select "Environment variable", with `GITHUB_TOKEN` as key and the token as value.

##### 2.2 Create DigitalOcean token and add it to Terraform Cloud

Create a DigitalOcean personal access token

"Variables" tab, "Add variable", select "Environment variable", with `DIGITALOCEAN_TOKEN` as key and the token as value.

#### 4. Infrastructure provisioning

##### a) Provision GitHub repository using Terraform

Plan the changes:

```bash
terraform plan -var-file=staging.tfvars
```

review and apply them:

```bash
terraform apply -var-file=staging.tfvars
```

and then add commits on top of the initial commit provisioned by Terraform.

##### b) Import the repository into Terraform state

Create a GitHub repository and push the initial commit. Then, import it into the Terraform state as in:

```bash
terraform import -var-file=staging.tfvars module.base.github_repository.repo doge-test
```

Finally, plan, review and apply the changes as described above in the option **a)**.

#### 5. Create a Terraform Cloud token and add it as GitHub repository secret

Create token https://app.terraform.io/app/settings/tokens

#### 4. Plan and apply

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
