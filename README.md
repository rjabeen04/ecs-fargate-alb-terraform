# ECS Fargate + ALB + WAF (Terraform)

This repository contains a **production-style Terraform project** that deploys a secure, scalable AWS architecture using **ECS Fargate**, **Application Load Balancer (ALB)**, and **AWS WAF**, with **remote state** in **S3 + DynamoDB locking**.

---

## Architecture Overview

```mermaid
flowchart TB
  user[User / Browser] -->|HTTP :80| alb[ALB]
  waf[AWS WAFv2] -. protects .-> alb

  subgraph vpc[VPC]
    subgraph pub[Public Subnets]
      alb
      nat[NAT Gateway]
      igw[Internet Gateway]
    end

    subgraph priv[Private Subnets]
      ecs[ECS Fargate Tasks\n(nginx)]
    end
  end

  alb --> tg[Target Group\n(target_type = ip)]
  tg --> ecs

  ecs -->|Outbound| nat
  nat --> igw
  igw --> internet[(Internet)]

