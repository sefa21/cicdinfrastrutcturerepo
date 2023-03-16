provider "aws" {
    region = "us-east-1"
    secret_key = "KInbashoKCyVvZ9CIoWqCBuKy23sh+OXGZkGIMZ/"
    access_key = "AKIAR3WVC34K25Z4QQBU "
}

terraform {
    backend "s3" {
        encrypt = false
        bucket = "tf-state-s3"
        dynamodb_table = "tf-state-lock-dyanamo"
        key = "path/path/terraform-tfstate"
        region = "us-east-1"
    }
}


resource "aws_vpc" "tf_test"{
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = true
    
}

resource "aws_subnet" "tf-subnet-public"{
    vpc_id = aws_vpc.tf_test.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"

}

resource "aws_subnet" "tf-subnet-private"{
    vpc_id = aws_vpc.tf_test.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"

}

resource "aws_eks_cluster" "testclusterkesse" {
 name = "testclusterkesse"
 
}

resource "aws_eks_node_group" "testnode-kesse" {
  cluster_name    = aws_eks_cluster.testclusterkesse.name
  node_group_name = "testnode-kesse"
}