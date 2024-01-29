terraform {
  backend "oss" {
    bucket              = "terraform-oss-backend-getting-started-2"
    key                 = "remote-1.tfstate"
    prefix              = "test1/state"
    tablestore_endpoint = "https://tf-state-1.cn-shanghai.ots.aliyuncs.com"
    region              = "cn-shanghai"
    tablestore_table    = "statelock"
  }

}


provider "alicloud" {
  region = "cn-shanghai"
}

resource "alicloud_security_group" "getting_stahted_sg" {
  name        = "getting_stahted_sg"
  description = "getting_stahted_sg"
  vpc_id      = "vpc-uf6wipm4osx7li80phtjp"
}
