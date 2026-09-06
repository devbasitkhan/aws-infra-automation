# AWS Infrastructure Automation with Terraform

A compact Infrastructure-as-Code project for provisioning a small AWS application environment with Terraform.

The current design creates a VPC across two Availability Zones, a public EC2 web-server subnet, private database subnets, security-group boundaries, and a MySQL RDS instance. The repository is intended as a focused infrastructure project rather than a production reference architecture.

## Architecture

```text
Internet
   |
Internet Gateway
   |
Public Subnet (AZ A)
   |
EC2 Web Server
   |
   | MySQL / 3306 allowed by security-group reference
   v
+----------------------- VPC -----------------------+
|                                                   |
|  Private DB Subnet (AZ A)   Private DB Subnet (AZ B)
|              \                /                   |
|               \-- RDS MySQL --/                  |
|                                                   |
+---------------------------------------------------+
```

## What This Project Demonstrates

- Terraform provider and version management
- AWS VPC and subnet provisioning
- Multi-AZ subnet design for RDS
- Internet Gateway and public routing for EC2
- EC2 security-group configuration
- RDS access restricted to the EC2 security group
- Sensitive Terraform input handling
- Reusable variables and useful outputs

## Repository Structure

```text
.
├── main.tf
├── provider.tf
├── variables.tf
├── network.tf
├── ec2.tf
├── rds.tf
├── outputs.tf
├── terraform.tfvars.example
└── .gitignore
```

## Prerequisites

- Terraform 1.5+
- An AWS account
- AWS credentials configured locally using an appropriate AWS-supported credential mechanism
- An existing EC2 key pair in the selected AWS region

## Usage

1. Clone the repository.
2. Copy the example variable file:

```bash
cp terraform.tfvars.example terraform.tfvars
```

3. Set your own values in `terraform.tfvars`. In particular, use your own public IP/CIDR for SSH access and provide the database password locally.
4. Initialize and review the plan:

```bash
terraform init
terraform validate
terraform plan
```

5. Apply when you are satisfied with the plan:

```bash
terraform apply
```

6. Destroy the lab infrastructure when finished to avoid unnecessary AWS charges:

```bash
terraform destroy
```

## Security Notes

- `terraform.tfvars`, Terraform state files and local Terraform directories are gitignored.
- The database password has no committed default value and is marked sensitive.
- SSH access is controlled through `ssh_cidr`; do not use `0.0.0.0/0` for normal use.
- RDS is placed in private subnets and accepts MySQL traffic only from the EC2 security group.
- Terraform state can contain sensitive values; for team/production use, move state to a properly secured remote backend with locking and encryption.

## Scope

This is intentionally a small portfolio/lab infrastructure project. A production environment would normally add controls such as HTTPS/load balancing, hardened instance access (for example SSM instead of SSH), secrets management, monitoring, backups, remote state, stronger database lifecycle policies and a broader high-availability design.
