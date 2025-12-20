# Bateman Tree Goods

A single-page website for Bateman Tree Goods, offering locally made furniture and wood craft items on Capitol Hill in Washington, DC.

## Features

- Clean, spartan design with dark green on white color scheme
- Fully responsive HTML/CSS layout
- Vanilla JavaScript for interactivity
- Static site hosted on AWS S3
- Infrastructure managed with Terraform

## Local Development

To view the site locally, simply open `index.html` in your web browser:

```bash
open index.html
```

Or use a simple HTTP server:

```bash
# Using Python 3
python3 -m http.server 8000

# Using Node.js (if http-server is installed)
npx http-server
```

Then navigate to `http://localhost:8000` in your browser.

## Deployment

The site is deployed to AWS S3 using Terraform.

### Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform >= 1.0 installed

### Deployment Steps

1. Copy the example variables file:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your desired bucket name and AWS region:
   ```hcl
   bucket_name = "your-unique-bucket-name"
   aws_region  = "us-east-1"
   ```

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Review the planned changes:
   ```bash
   terraform plan
   ```

5. Apply the configuration:
   ```bash
   terraform apply
   ```

6. After successful deployment, Terraform will output the website URL.

### Updating the Site

After making changes to `index.html`, `styles.css`, or `script.js`, run:

```bash
terraform apply
```

Terraform will automatically detect the changes and update the S3 bucket.

## Project Structure

```
.
├── index.html              # Main HTML file
├── styles.css              # CSS stylesheet
├── script.js               # JavaScript functionality
├── main.tf                 # Main Terraform configuration
├── variables.tf            # Terraform variables
├── outputs.tf              # Terraform outputs
├── terraform.tfvars.example # Example Terraform variables
├── .gitignore              # Git ignore file
└── README.md               # This file
```

## License

© 2025 Bateman Tree Goods. All rights reserved.