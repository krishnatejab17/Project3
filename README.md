Multi-Stage Pipeline for ECS (Blue-Green Deployment)

Application deployed on ECS Fargate

Two environments: Dev + Prod

Blue-Green deployment using CodeDeploy

GitHub Actions pipeline triggers:

Build → Push to ECR

Deploy to Dev

Approval required → Deploy to Prod.