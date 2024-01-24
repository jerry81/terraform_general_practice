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