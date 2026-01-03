# ECS Fargate + ALB + WAF (Terraform)

This repository demonstrates a **production-style AWS infrastructure** built using **Terraform**, following real-world DevOps best practices.

The project provisions a **containerized application running on ECS Fargate**, exposed through an **Application Load Balancer (ALB)**, protected by **AWS WAF**, with **remote Terraform state**, **ALB access logging to S3**, and **cost-control lifecycle policies**.

This repo is designed for **learning, practice, and interview readiness**.

---

## Architecture Overview

High-level flow:

User  
→ Application Load Balancer (Public Subnets)  
→ ECS Fargate Tasks (Private Subnets)  
→ NGINX container  

Security & Operations:
- AWS WAF attached to ALB
- ALB access logs stored in S3
- S3 lifecycle rule for log expiration
- Terraform remote state with locking

---

## Repository Structure

```text
ecs-fargate-alb-terraform/
├── bootstrap/          # One-time setup for Terraform remote state
│   ├── S3 bucket (tfstate)
│   └── DynamoDB table (state locking)
│
├── modules/            # Reusable Terraform modules
│   ├── network/        # VPC, subnets, IGW, NAT Gateway, routes
│   ├── alb/            # ALB, listeners, target group, WAF
│   └── ecs/            # ECS cluster, task definition, service
│
├── envs/
│   ├── dev/            # Development environment
│   └── prod/           # Production-style environment
│
├── .gitignore
└── README.md

