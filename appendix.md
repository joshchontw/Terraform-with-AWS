## Configuration drift

With infrastructure-as-code, the issue of configuration drift comes up. Even the most well intentioned companies can fall victim to this. If even one person changes configuration manually, that can mess up the intended state. With Terraform, it keeps a state file wherever you specify, and this file will be the reference point, the source of truth.

> Instance deployed with Terraform

![image](https://user-images.githubusercontent.com/81763406/161595398-93e2681c-0549-40fb-8573-660eb2a0d75e.png)

If I now want to change the processor type, Terraform will refer to the state file and see if this deviates from that source of truth. If it does, Terraform will alert and ask you if you want to move forward. If there are no changes, everything stays the same. 

> Where before the instance type was 't2.micro', I've changed it now to 't4.micro'

![image](https://user-images.githubusercontent.com/81763406/161595617-a2045f24-9958-4464-bc51-aaa05bb90018.png)

> The state file that Terraform refers to

![image](https://user-images.githubusercontent.com/81763406/161596053-1040ce5a-d949-4260-9f94-efb596eeb609.png)

At the very bottom, the current state that Terraform knows of the instance is that it has a 't2.micro' processor.

> After running the terraform apply command

![image](https://user-images.githubusercontent.com/81763406/161595801-6dd4cc38-879e-4ce3-8b13-1554fec41811.png)

Again, at the very bottom, we see that the instance type will change from 't2' to 't4.micro'. Because the instance type changes, the instance has to be deleted and spun up again.

## Hiding key files in my repository

To SSH into EC2 instances, we need to have the private key file that is associated with the instance. Hosting my key out in the open in my repository is never a good idea, which is why I make use of the '.gitignore' file.

> In the .gitignore file, I've added the 'testkey.pem' file so that when I push my files up to this GitHub repository, my private key file just stays on my local machine without being exposed on this public repository

![image](https://user-images.githubusercontent.com/81763406/161596801-aadb6dfb-2f60-4066-a574-75cf474d5838.png)

> My private key file is in my local machine but not on this repository

![image](https://user-images.githubusercontent.com/81763406/161596900-972b8f36-7eee-43cb-9aa1-10f715508b07.png)
