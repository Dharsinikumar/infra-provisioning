# Infra Provisioning with Terraform

![Terraform](https://img.shields.io/badge/Terraform-1.14.8-623CE4?style=for-the-badge&logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Cloud-orange?style=for-the-badge&logo=amazonaws)
![WSL](https://img.shields.io/badge/WSL-Ubuntu%2024.04-4D4D4D?style=for-the-badge&logo=ubuntu)
![Git](https://img.shields.io/badge/Git-Version%20Control-F05032?style=for-the-badge&logo=git)
![Docker](https://img.shields.io/badge/Docker-Containerization-2496ED?style=for-the-badge&logo=docker)

Terraform-based Infrastructure as Code project to provision AWS infrastructure using reusable modules for VPC and EC2.

## Architecture

```text
                        +----------------------+
                        |      Internet        |
                        +----------+-----------+
                                   |
                                   |
                        +----------v-----------+
                        |   Internet Gateway   |
                        +----------+-----------+
                                   |
                    +--------------v--------------+
                    |            VPC              |
                    |        10.0.0.0/16         |
                    +--------------+--------------+
                                   |
                 +-----------------+-----------------+
                 |                                   |
      +----------v----------+             +----------v----------+
      |   Public Subnet     |             |   Private Subnet    |
      |    10.0.1.0/24      |             |    10.0.2.0/24      |
      +----------+----------+             +---------------------+
                 |
                 |
      +----------v----------+
      |   EC2 Instance      |
      |   Amazon Linux 2    |
      |      Nginx          |
      +---------------------+
