# ML Infra - Transcription Model

## Requirements

- Handle real-time audio transcription with variable load
- Support basic monitoring and performance tracking
- Maintain high availability
- Comply with healthcare and data protection requirements
- Handle real-time audio streaming at scale

## Infrastructure design for Transcription Model

![architecture diagram](./architecture-diagram.png)

## Key Design Decisions

### Design Decisions - Deployment:

To handle real-time audio transcription with variable load, I have opted to deploy the model via SageMaker endpoints with an associated containerised service deployed via Kubernetes. The advantages include:

- The separation of the model and service decouples model logic and business logic
- The separation of business logic and model logic simplifies model deployment process
- Enables the model to be deployed on suitable hardware without impacting the entire EKS cluster
- Deploying the model via Sagemaker model endpoints allows the model to be called by multiple services if necessary, catering to multiple business use cases; provided that autoscaling and usage quotas are in place

### Design Decisions - Networking and Security:

To address network security concerns, I decided to route all incoming traffic through a Cloudflare proxy. Additionally, I chose to create a VPC with an internet gateway to encapsulate the Kubernetes and SageMaker infrastructure, with gateway endpoints for accessing S3 and ECR services. All data ingested into and out of S3 is encrypted via AWS-managed KMS keys. 

- Routing traffic through Cloudflare helps block DDoS and bot attacks.
- ACLs can be configured to only accept ingress traffic from Cloudflare IPs.
- VPC gateway endpoints ensure that traffic remains within the AWS network.
- All S3 data is encrypted at rest by default.
- A VPC enables the placement of EKS worker nodes across multiple availability zones for high availability.
- EKS allows fine-grained access to external resources by associating a Kubernetes service account with an AWS IAM role.
- EKS allows governing of access to clusters via IAM, combined with Kubernetes RBAC, for fine-grained access control.

### Design Decisions - Observability:

To monitor the system, I utilised two main services: CloudWatch and Datadog, with Slack and PagerDuty for alerting.

- CloudWatch metrics can be used to scale both SageMaker and EKS workloads.
- Datadog provides a unified platform for analytics. In my design, I ensured that only performance metrics are ingested into Datadog (no PHI data will be sent to Datadog). However, Datadog can be configured to be HIPAA-compliant if necessary.
- Alerts can be created in Datadog, with notifications sent via Slack and/or PagerDuty to alert on-call engineers of any issues.

## Thoughts on Disaster Recovery

All infrastructure should be managed using Infrastructure as Code (IaC). In the event of a critical issue, this allows for the easy recreation of infrastructure. Loss of access can pose challenges, particularly with third-party services and Kubernetes clusters. To address this, break-glass accounts should be securely stored in a password vault for emergency access.

Data loss can be catastrophic, especially in production databases. Therefore, it is critical to back up data where necessary in a cadence that suits the business (e.g. daily or hourly snapshotting of volumes).