# Deploying a Nodejs with SSL on a Linux Server

This project demonstrates the deployment of a sample **Node.js application** to a Linux server on AWS. The setup includes **continuous deployment** using GitHub Actions, **Apache** as the web server, and **Let's Encrypt** for SSL configuration. Infrastructure provisioning is automated using **Terraform** and **Ansible**.

---

![Build Status](https://github.com/PreciousDipe/translator_app/actions/workflows/ci-pipeline.yaml/badge.svg)

---

## **Overview**

1. **GitHub Repository**: Hosts the application code and CI/CD pipeline configuration (GitHub Actions).
2. **AWS Cloud**:
   - **EC2 Instance**: Linux server hosting the application.
   - **Security Group**: Configured for HTTPS (port 443), HTTP (port 80), and SSH (port 22).
3. **Apache**:
   - Acts as a reverse proxy to route traffic to the application.
   - Configured with **Let's Encrypt SSL certificates** for HTTPS.
4. **PollyGlot App**:
   - **Node.js Application**: PollyGlot is a web application designed to provide accurate translations using advanced generative AI models. Users can enter text, select a target language, and receive translated text with the help of **Google's Generative AI**.
   - Optional database connection (e.g., PostgreSQL or MySQL).
5. **Infrastructure Automation**:
   - **Terraform** provisions AWS resources (EC2, Security Group, Key Pair).
   - **Ansible** manages server configurations (Apache, app setup, SSL).

---

## **Getting Started**

### **Prerequisites**

1. **Domain Name**: Ensure you have a domain or subdomain (e.g., `devops.example.com`).
2. **AWS Account**: To provision cloud infrastructure.
3. **GitHub Repository**: Store your app and deployment configurations.
4. **Terraform and Ansible**:
   - Install [Terraform](https://developer.hashicorp.com/terraform/downloads) and [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html).
5. **Git**: For version control.

---

## **Setup Instructions**

### **1. Infrastructure Setup (Terraform)**

Use the `main.tf` file to:
- Create an EC2 instance.
- Configure a security group.
- Generate SSH keys for server access.

Run the following commands:
```bash
terraform init
terraform plan
terraform apply
```

## Project Structure
```java
├── translator_app/              
│   ├── .github/workflows/
│   │   └── ci-pipeline.yaml    
│   ├── public/
│   │   ├── assets/
│   │   │   ├── fr-flag.png
│   │   │   ├── jpn-flag.png
│   │   │   ├── sp-flag.png
│   │   │   ├── chn-flag.png
│   │   │   └── parrot.png
│   │   ├── index.html
│   │   ├── index.css
│   │   └── index.js   
│   ├── Terraform/
│   │   ├── deploy-app.yml
│   │   ├── main.tf
│   │   ├── provider.tf
│   ├── .gitignore
│   ├── package-lock.json
│   ├── package.json            
│   ├── README.md
│   └── server.js
```

##### link to the [pollyglot](https://pollyglot.mooo.com/) webapp 