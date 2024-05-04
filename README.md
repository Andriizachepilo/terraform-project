
CloudSmartHome is a cloud-native smart home solution designed and implemented as part of a cloud engineering project. Leveraging the power of AWS and Terraform, CloudSmartHome provides a scalable and resilient microservices network for managing home automation systems.

Overview
CloudSmartHome was developed with the aim of revolutionizing home automation through cloud technologies. It offers a modular microservices architecture built on AWS infrastructure, allowing for seamless integration and management of various smart home devices.

Architecture
The architecture of CloudSmartHome is meticulously crafted to ensure optimal performance, security, and scalability. Key components of the architecture include:

Networking
CloudSmartHome establishes a robust Virtual Private Cloud (VPC) across multiple availability zones to ensure high availability and fault tolerance. The VPC architecture incorporates Public and Private subnets, providing a secure and segregated environment for different components of the system.

Security
Security is paramount in CloudSmartHome. The system implements a multi-layered security approach, including:

Secure bastion host architecture for controlled access to EC2 instances.
Fine-grained security groups for enforcing access controls and network isolation.
Encrypted communication channels to safeguard sensitive data.
Databases
CloudSmartHome utilizes DynamoDB, a fully managed NoSQL database service, for storing and managing data related to smart home devices. The database design is optimized for performance and scalability, ensuring seamless operation even under high loads.

App Services
The application layer of CloudSmartHome consists of microservices deployed on EC2 instances. Each service is designed to handle specific functionalities such as device control, data processing, and user authentication. The services are deployed in a highly available and fault-tolerant manner to ensure uninterrupted operation.

Load Balancing
To distribute incoming traffic efficiently and ensure high availability of services, CloudSmartHome employs Application Load Balancers (ALBs) for public-facing services and internal load balancers for inter-service communication. The load balancers intelligently route traffic to healthy instances, providing a seamless user experience.

Autoscaling
CloudSmartHome leverages autoscaling capabilities to dynamically adjust the number of EC2 instances based on workload demand. This ensures optimal resource utilization and cost efficiency, allowing the system to scale seamlessly with changing requirements.


Usage
Getting Started
AWS Account and Credentials

Create an AWS Account
Install AWS CLI
Create an AWS IAM User with Admin or Power User Permissions
this user will only be used locally
Configure the AWS CLI with the IAM User from the previous step.
Terraform will read your credentials via the AWS CLI
Other Authentication Methods with AWS and Terraform
Terraform

Install HashiCorp Terraform
Install Node.js
Before proceeding, ensure that you have authenticated your AWS account via the AWS CLI using your access keys.

Usage: Create an key-pair
In order to ssh into the bastion (and then into the app servers/instances), remember to create a key pair in the aws console with the name of smarthome-apps and apply the ssh command in the same directory that your .pem key file is in.

Usage: Create an IAM USER
You need to create an IAM user for these future services (lighting, heating) to interact with the databases so that they can authenticate the requests.

Use the IAM service on the AWS console to create a user that;

Has policies which allow full access to DynamoDB
Once created, give this user CLI access and save your keys somewhere as you will need to inject them later on into some of the services. (Check the .env.local files)
Usage: Customize the values of the terraform.tfvars file
To use these modules in your infrastructure, redirect yourself to the terraform.tfvars file located in the root directory and customize the values according to your specific requirements.

