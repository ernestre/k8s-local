_default:
  @just --list

apply: init
    terraform apply -auto-approve

init:
    terraform init

destroy:
    terraform destroy -auto-approve

recreate: destroy apply

plan:
    terraform plan

output:
    terraform output

reset:
    kind delete clusters default
    rm -rf .terraform .terraform.lock.hcl terraform.tfstate terraform.tfstate.backup
