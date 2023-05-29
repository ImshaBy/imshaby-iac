cd ./tf
terraform init
terraform plan -var-file ../envs/producation.tfvars
terraform apply -var-file ../envs/producation.tfvars