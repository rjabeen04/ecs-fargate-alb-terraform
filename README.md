# ECS Fargate + ALB + WAF (Terraform)

This repository contains a **production-style Terraform project** that deploys a secure, scalable AWS architecture using **ECS Fargate**, **Application Load Balancer**, and **AWS WAF**, with **remote state management**.

The project is designed to demonstrate **real-world DevOps and Terraform best practices** such as modular design, environment separation, and cost-aware infrastructure lifecycle management.

---

## Architecture Overview

```mermaid
flowchart TB
  user[User / Browser] -->|HTTP :80| alb[Application Load Balancer]
  waf[AWS WAFv2] -. protects .-> alb

  subgraph VPC[VPC]
    subgraph PublicSubnets[Public Subnets (2 AZs)]
      alb
      nat[NAT Gateway]
      igw[Internet Gateway]
    end

    subgraph PrivateSubnets[Private Subnets (2 AZs)]
      ecs[ECS Fargate Tasks (nginx)]
    end
  end

  alb --> tg[Target Group (IP mode)]
  tg --> ecs

  ecs -->|Outbound access| nat
  nat --> igw
  igw --> internet[(Internet)]


