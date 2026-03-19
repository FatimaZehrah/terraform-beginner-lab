# Terraform Beginner Lab

## Project Overview
This project is a beginner-friendly Terraform lab that provisions AWS infrastructure on Amazon Web Services (AWS) using Infrastructure as Code (IaC).

The lab creates the following resources:
- 1 custom Virtual Private Cloud (VPC)
- 1 subnet inside the VPC
- 1 EC2 instance inside the subnet

This version of the lab is a customized implementation rather than a direct copy of a starter repository. The project is structured into separate Terraform files for readability and maintainability, uses variables for reusable configuration, and includes outputs for easier verification after deployment.

---

## Project Objectives
The goal of this lab is to understand the end-to-end Terraform workflow on AWS.

By completing this lab, you will learn how to:
- configure Terraform to work with AWS
- use Infrastructure as Code to create cloud resources
- organize Terraform code into multiple files
- use variables instead of hardcoding values
- preview changes before applying them
- deploy resources using `terraform apply`
- verify created resources in both Terraform and AWS Console
- rerun the project safely after making updates
- destroy provisioned resources when the lab is complete
- manage project files using Git and GitHub

---

## Technologies Used
This lab uses the following tools:
- **Terraform** for infrastructure provisioning
- **AWS CLI** for AWS authentication and account configuration
- **AWS IAM** for secure programmatic access
- **Git** for version control
- **GitHub** for repository hosting
- **VS Code** for editing files
- **PowerShell** for running commands

---

## Infrastructure Created
This lab provisions the following AWS resources in the `us-east-1` region:
- **VPC**: `lab-vpc`
- **Subnet**: `lab-subnet`
- **EC2 Instance**: `lab-ec2-instance`

---

## Project Structure
The repository is organized as follows:

- `main.tf`  
  Contains the AWS provider configuration and the resource definitions for the VPC, subnet, and EC2 instance.

- `variables.tf`  
  Defines reusable Terraform input variables.

- `terraform.tfvars`  
  Stores the actual values assigned to the variables.

- `outputs.tf`  
  Defines the values Terraform displays after successful deployment, such as IDs and public IP.

- `.gitignore`  
  Prevents generated Terraform files and state files from being pushed to GitHub.

- `README.md`  
  Documents the lab setup, execution steps, rerun steps, verification process, and cleanup steps.

---

## Prerequisites
Before running this lab, make sure the following are completed:

### 1. Git Installed
Check using:
```bash
git --version
```

### 2. Terraform Installed
Check using:
```bash
terraform -version
```

### 3. AWS CLI Installed
Check using:
```bash
aws --version
```

### 4. AWS Account Available
You need an AWS account with access to create:
- VPCs
- subnets
- EC2 instances

### 5. IAM User with Programmatic Access
For this lab, it is recommended to use an IAM user instead of the root user.

The IAM user should:
- have permission to create AWS resources
- have an Access Key ID and Secret Access Key
- be configured in AWS CLI using:

```bash
aws configure
```

When prompted, enter:
- AWS Access Key ID
- AWS Secret Access Key
- Default region: `us-east-1`
- Default output format: `json`

### 6. VS Code Installed
Used to create and edit Terraform files.

---

## Terraform Configuration Used
The `terraform.tfvars` file stores the input values used in this lab.

Example values used in this project:

```hcl
aws_region    = "us-east-1"
ami_id        = "ami-0e2c8caa4b6378d8c"
instance_type = "t3.micro"
vpc_name      = "lab-vpc"
subnet_name   = "lab-subnet"
instance_name = "lab-ec2-instance"
```

### Note on Instance Type
The lab initially used `t2.micro`, but it was updated to `t3.micro` because the account's free-tier-eligible instance types differed. Always check your account eligibility if Terraform returns an EC2 instance type error.

---

## How to Run the Lab
Follow the steps below from the root project folder.

### Step 1: Initialize Terraform
This downloads the provider plugins required by Terraform.

```bash
terraform init
```

Expected result:
- Terraform initializes successfully
- a `.terraform/` folder is created

---

### Step 2: Validate the Configuration
This checks for syntax or configuration issues.

```bash
terraform validate
```

Expected result:
```bash
Success! The configuration is valid.
```

---

### Step 3: Preview the Changes
This shows what Terraform plans to create without actually creating it.

```bash
terraform plan
```

Expected result:
- Terraform shows the resources that will be added
- Example summary:

```bash
Plan: 3 to add, 0 to change, 0 to destroy.
```

---

### Step 4: Apply the Configuration
This creates the infrastructure in AWS.

```bash
terraform apply
```

When prompted:

```bash
yes
```

Expected result:
- VPC created
- subnet created
- EC2 instance created
- output values displayed at the end

---

## Expected Terraform Outputs
After a successful apply, Terraform should display values similar to the following:
- `vpc_id`
- `subnet_id`
- `instance_id`
- `instance_public_ip`

These outputs help confirm that the infrastructure was deployed successfully.

---

## How to Verify the Resources
There are two ways to verify the lab.

### 1. Verify Using Terraform
Run:

```bash
terraform state list
```

Expected resources:

```bash
aws_instance.lab_ec2
aws_subnet.lab_subnet
aws_vpc.lab_vpc
```

### 2. Verify in AWS Console
Set the AWS region to **N. Virginia (`us-east-1`)** and check:

- **EC2 Console** → Instances  
  Confirm the instance named `lab-ec2-instance`

- **VPC Console** → Your VPCs  
  Confirm the VPC named `lab-vpc`

- **VPC Console** → Subnets  
  Confirm the subnet named `lab-subnet`

---

## How to Re-Run the Lab
There are several cases where you may want to rerun the lab.

### Case 1: You changed Terraform code
If you edit any of these files:
- `main.tf`
- `variables.tf`
- `terraform.tfvars`
- `outputs.tf`

Run:

```bash
terraform plan
terraform apply
```

Terraform will compare the desired configuration with the current state and apply only the necessary updates.

---

### Case 2: You closed VS Code and want to continue later
1. Reopen the project folder in VS Code
2. Open PowerShell in that folder
3. Run:

```bash
terraform init
terraform plan
terraform apply
```

Note: running `terraform init` again is safe. It rechecks providers and ensures the project is initialized properly.

---

### Case 3: You want to verify current deployed infrastructure again
Run:

```bash
terraform state list
terraform output
```

This helps you inspect the current state and outputs without recreating resources.

---

### Case 4: You changed the instance type or another variable
If you update values in `terraform.tfvars`, save the file and run:

```bash
terraform plan
terraform apply
```

Terraform will show whether resources will be updated, replaced, or left unchanged.

---

## Common Re-Run Notes
When rerunning the lab, keep these points in mind:
- always run commands from the project root folder
- keep AWS CLI configured with valid IAM credentials
- do not delete `terraform.tfstate` manually while Terraform is still managing the infrastructure
- do not push `.tfstate` files to GitHub
- if an AWS resource already exists outside Terraform, Terraform may not manage it unless it created it

---

## Troubleshooting Notes
### 1. Terraform not recognized
Cause:
- Terraform not installed or not added to PATH

Fix:
- install Terraform
- add the Terraform folder to system PATH
- restart terminal or VS Code

### 2. AWS CLI not configured
Cause:
- AWS credentials not set up

Fix:
Run:
```bash
aws configure
```

### 3. EC2 instance type rejected
Cause:
- the instance type may not be eligible for your account or region

Fix:
Check free-tier-eligible instance types using:

```bash
aws ec2 describe-instance-types --filters Name=free-tier-eligible,Values=true --query "InstanceTypes[*].[InstanceType]" --output text
```

Then update `terraform.tfvars` with a valid instance type.

### 4. Git push rejected
Cause:
- remote repository already has content not present locally

Fix:
Run:
```bash
git pull origin main --allow-unrelated-histories
```
Resolve any merge conflicts, commit again, and push.

---

## Terraform State Files
Terraform creates local state files to track deployed infrastructure.

Important generated files include:
- `.terraform/`
- `terraform.tfstate`
- `terraform.tfstate.backup`

These files are not pushed to GitHub because they are excluded in `.gitignore`.

### Why this matters
Terraform uses the state file to know:
- what resources it created
- the current resource IDs
- how to compare desired and actual infrastructure

---

## How to Destroy the Lab Resources
When the lab is complete, delete the infrastructure to avoid unnecessary AWS charges.

Run:

```bash
terraform destroy
```

When prompted:

```bash
yes
```

Expected result:
- EC2 instance deleted
- subnet deleted
- VPC deleted

---

## What Is New in This Version
This implementation includes improvements beyond a minimal beginner Terraform setup.

Custom additions in this version include:
- separating Terraform code into multiple files for clarity
- using variables instead of hardcoding all values in one file
- adding output values for easier deployment verification
- using cleaner and more descriptive AWS tags
- documenting rerun steps clearly
- documenting troubleshooting and destroy steps
- maintaining the project in GitHub with version control

---

## Learning Outcomes
By completing this lab, the following concepts were practiced:
- setting up Terraform locally
- configuring AWS CLI with IAM credentials
- creating cloud infrastructure through Terraform
- validating and planning infrastructure before deployment
- troubleshooting apply-time AWS errors
- rerunning infrastructure safely after changes
- using Git and GitHub for infrastructure code management
- documenting a Terraform project professionally

---

## Author
**Fatima Zehrah**
