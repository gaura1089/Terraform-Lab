# #!/bin/bash
# # terraform-destroy-all.sh

# # List all workspaces and clean formatting
# workspaces=$(terraform workspace list | sed 's/*//g' | awk '{$1=$1};1')

# # Loop through each workspace
# for ws in $workspaces; do
#   echo "Switching to workspace: $ws"
#   terraform workspace select "$ws"
#   echo "Destroying resources in workspace: $ws"
#   terraform destroy -auto-approve
# done
