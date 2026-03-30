Architecture
------------
![alt text](Dashboard_counting.png)

Features
---------
-Automated infrastructure provisioning using Terraform
-AWS EC2 instances - "Dashboard and Counting instances"
-Secure access using SSH key pairs
-Custom VPC with public/private subnets
-Security Groups for controlled traffic
-User data scripts for dashboard and counting app to start automatically after bootup instances

Infrastructure Components
---------------------------
VPC
Subnets (Public / Private)
Internet Gateway
Route Tables
EC2 Instances
Elastic IP
Security Groups
Key Pair (TLS generated)