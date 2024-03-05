# vtb_aws_terraform

The repository contains code which will build or provision AWS Infrastructure. As of now it is very basic which include only VPC and S3, but very soon this will be extended and many more new resources and configuration will be added.

We are using github action to provision the infrastructure. Below are the steps you can follow to build your own infrastructure in your own enviornment.

1. To provision infrastructure in our enviornment take fork of the repository and create a Github secret as mentioned in deployement.yaml file.
2. Once secret is configured change variables in variables.tf file to match your need.
3. Select CIDR range for VPC according to your need.
4. Upload you publik key file to code root directory.
5. Once everything is done commit the code and merge the code.
