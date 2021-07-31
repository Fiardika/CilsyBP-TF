#!/bin/bash
#AWS Configure
aws configure set default.region ap-southeast-1
aws configure set aws_access_key_id 'xxxxxxxxxxxxxxxxxxxxxx'
aws configure set aws_secret_access_key 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxx'

#Kops Configure
export KOPS_STATE_STORE=s3://k8s-bigpro
export NETWORK_CIDR=192.168.1.0/24

#Create Kops Cluster
kops create cluster --node-count=2 --node-size=t2.small --master-size=t2.medium --zones=ap-southeast-1a,ap-southeast-1b --name=k8s.fiardika.xyz
kops update cluster --name k8s.fiardika.xyz --yes --admin
kops validate cluster --wait 10m

#Kops Konfig for Jenkins User
sudo cp ~/.kube/config /var/lib/jenkins/.kube/
sudo chown jenkins:jenkins /var/lib/jenkins/.kube/config
kops export kubecfg --admin --state s3://k8s-bigpro