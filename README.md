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