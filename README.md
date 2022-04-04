# Terraform with AWS

This repository showcases how Terraform can deploy resources in AWS. Terraform deploys resources using the 'terraform apply' command. The great thing about this command is that it gives us a chance to see what will be created. We can review, and adjust accordingly. The opposite action (deleting) is triggered with the 'terraform destroy' command.

## Part 1

This first [script](https://github.com/joshchontw/lab-03-terraform/blob/main/part1/main.tf), deploys an Ubuntu EC2 instance. The [variables](https://github.com/joshchontw/lab-03-terraform/blob/main/part1/variables.tf) file provides some common default variables, such as region, instance type and tags. These variables are referenced in the main.tf script with the 'var.{variable name}' construct.

> Confirming that we want to continue with the deployment

![image](https://user-images.githubusercontent.com/81763406/160303238-26cc4f85-35a9-44c2-9b26-05c92a6595e8.png)

> We see our new instance with the name 'part1-testing'. This name was applied thanks to our tags variable we specified in our variables file

![image](https://user-images.githubusercontent.com/81763406/160303194-f0dcdf59-8bc0-4a28-8b59-64e2d85f9f00.png)

> Deleting our newly created instance

![image](https://user-images.githubusercontent.com/81763406/160303331-08d22e82-1105-45fc-af31-9e5ae677a612.png)

> The instance is now terminated

![image](https://user-images.githubusercontent.com/81763406/160303353-acc01c54-b729-4272-9cf8-b25cb0f914f2.png)
---

## Part 2

This next task integrates Ansible with Terraform. These two applications are a match made in heaven. Terraform is a tool to create/deploy cloud resources, and Ansible comes in with the capability to configure the newly created resources. 
