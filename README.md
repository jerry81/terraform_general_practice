# terraform_general_practice

## terraform getting started

- assuming docker desktop available
- terraform can control our docker?
- yes there apparently is a provider, docker
- definitions
  - "required providers" - from terraform registry by default
  - "source" - an optional hostname, namespace, provider type
- will run the default nginx image at localhost 8000

- notes:
```console
terraform init
```
- installed the provider plugins for docker
- creates .terraform.lock.hcl file to (like yarn.lock)

```console
terraform plan
```

shows the preview

```console
terraform apply
```

shows the preview and asks if you want to continue

```console
terraform destroy
```

stops the nginx

- so tf is controlling stuff on my computer

## provision AWS EC2

- needs tf cli
- needs aws cli
- need aws credentials

1.  configure aws cli
```console
aws configure
```
2. paste the code
  - note: AMI is amazon machine image (preconfiged vm  to create ec2 instances )
3.  init again
```console
terraform init
```
- notice that for each project you reinit
4.  auto-format
```console
terraform fmt
```
formats, then outputs names of changed files.
5.  validate for errors
```console
terraform validate
```
6.  apply
  - when applying had an issue - could not find the ami.
  - how to find ami?
```console
aws ec2 describe-images
```
- lists them all.
- they are like docker images
- just picked one ami-0fc0ab6d7593a9bd9
- (also ami catalog in the aws console)

- yes, like magic, infrastructure was created.

7.  review state
```console
terraform show
```
- yes, by adding, state automatically updated.

## modify tutorial

1.  change the ami of the exact same main.tf and see what happens
2.  1 added, one destroyed after apply
3.  id not retained, ami switched out, old instance destroyed

## variables tutorial

1.  put more tf files into same folder (no other hierarchies allowed)
2.  define variable with
```
variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "yourvalue"
}
```

## outputs tutorial

0.  first reapply the ec2
1. create outputs file
  - note syntax
  ```tf
  output "name_of_output" {
    description = ""
    value = aws_instance.app_server.id
    # this is apparently something from a resource only known after apply
  }
  ```
2. apply again with outputs
3.  then work with outputs.
  - terraform prints output
  - can query for output
```console
terraform output
```

- it is not necessary to first have the infrastructure before getting the outputs.
- q.  what's the practical application of outputs?
- a.  expose info to user, cross dependency between tf configs, integration with external systems

1.  trying apply with the output but no infrastructure up yet.

## remote state tutorial

- in prod env want secure encrypted state
- run tf in remote env with shared access to state
- tf cloud allows us to collaborate on infra changes
- tutorial migrates project to tf cloud

1.  tf account creation
2.  login
3.  get organization name
4.  add "cloud" or "remote backend" block to main.tf file
5.  terraform.tfstate no longer needed in each of our folders
6.  tf cloud can store secrets accessible as variables (like AWS AK/secret)

## oss for remote state

[ref](https://www.alibabacloud.com/help/en/terraform/latest/quick-start-for-alibaba-cloud-oss-backend-for-terraform)

- background:
  - Local state: local storage
    - By default, Terraform stores state data
      - locally in a file named terraform.tfstate
      - within the working directory.
  - Remote state: remote storage
    - Terraform stores state data in remote services such as Alibaba Cloud OSS, Terraform Cloud, and HashiCorp Consul. This improves state security and management flexibility, allowing state data to be shared between all members of a team regardless of the Terraform working environment and working directory.

```console
terraform init
```
- this will install the plugin for the backend (oss)
  - also grabs the state from oss
- oss is one of 13 backends supported
  - is standard (not enhanced) - meaning it supports state locking and storage

- plan, apply, destroy, other state modifiers will "lock" the state and modify the remote state

- read only commands like show and state use the local state

- when trying to create a ots called "terraform-remote" it complains that the instance already exists.

- ok so i can init with just the backend block

- now i need to actually create a state
- try create sec group
- need to reinit to bring alicloud provider in
- oh goody, the sg was created.
- now check if oss has anything

- file created at /test1/state/remote-1.tfstate

- so key-> filename
- path -> folder structure

- comparing to opteyes
- they also use backend "oss"
- they do not need tablestore related things
- they have "profile" (optional - alciloud  profile name  as set in shared cred file)

- manual test to see if things worked correctly.
- reclone the repo
- see if state is still correct.

- test result:  after cloning a fresh github
- i ran tf init
- then tf show
- got the proper state!