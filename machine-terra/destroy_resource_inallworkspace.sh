#!/bin/bash
terraform init
for workspace in $(terraform workspace list | sed 's/*//g' | tr -d ' ')
do
  terraform workspace select $workspace
  terraform destroy -auto-approve
done
