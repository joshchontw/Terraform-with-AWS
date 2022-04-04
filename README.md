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

This next task integrates Ansible with Terraform. These two applications complement each other well. Terraform is a tool to create/deploy cloud resources, and Ansible comes in with the capability to configure/change the newly created resources. 

This second [script](https://github.com/joshchontw/lab-03-terraform/blob/main/part2/main.tf) deploys an EC2 instance, installs Ansible on it, copies a [playbook](https://github.com/joshchontw/lab-03-terraform/blob/main/part2/hello_world.yaml) from my local machine to the instance in the cloud, and finally runs the playbook. All of this is done remote and in one command. We leverage Terraform's 'null_resource' resource to SSH into the instance and run commands. 

Within the 'null_resource' block, we have two provisioners:

![image](https://user-images.githubusercontent.com/81763406/161584165-3e113f50-11db-4b74-8f59-141651368785.png)

The 'file' provisioner allows us to copy a file from our local machine into the instance (our playbook). The 'remote-exec' provisioner allows us to execute commands on the instance as if we were at the terminal of that instance.

> A snippet of commands being executed on the instance

![image](https://user-images.githubusercontent.com/81763406/161585002-74255994-f19b-49db-8f92-59f45015f529.png)

> Output of our Ansible playbook

![image](https://user-images.githubusercontent.com/81763406/161585154-66dd4e89-5aa4-4384-b08f-555cb7601cbf.png)

> I've SSHed into the instance to confirm that the playbook from our local machine is also on the instance

![image](https://user-images.githubusercontent.com/81763406/161585628-56cd48cf-ff5b-4ca8-8e67-9cf106d7512d.png)

---

## Part 3

In part 3, we deploy resources using modules, one local and the other remote. 

#### [Local module](https://github.com/joshchontw/lab-03-terraform/tree/main/part3/local_module)

This local module deploys an EC2 instance and configures a simple webserver. We call the resource file in the same directory in the 'module' block with a 'source' of "./webserver_setup". Terraform will then know to look within the 'webserver_setup' folder to deploy our stack. 

> Once deployed, we check to see if our webserver is up as intended

![image](https://user-images.githubusercontent.com/81763406/161589720-a506ada9-077f-415f-9fdb-19a8102a3fbf.png)

---

#### [Github module](https://github.com/joshchontw/lab-03-terraform/tree/main/part3/github_module)

This module, hosted in a repository on my GitHub, deploys a simple VPC. Unlike a local module, the source of a remote repository should be a URL, where the resource stack file is located. 

> In our case, the resource file is on my GitHub.

![image](https://user-images.githubusercontent.com/81763406/161590164-bf6700c3-89a1-498c-b140-54c509ce324a.png)

> Our VPC, with the CIDR block of 10.0.0.0/16 is now deployed

![image](https://user-images.githubusercontent.com/81763406/161593377-0b7119b4-1a4a-4677-ae70-a8b02a8dec8c.png)
