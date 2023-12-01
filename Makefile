validate-task = (cd env/$1/ && terraform init -backend=false && terraform validate)
plan-task = (cd env/$1/ && terraform init && terraform plan -out plan.plan)
plan-apply-task = (cd env/$1/ && terraform init && terraform apply plan.plan)
apply-task = (cd env/$1/ && terraform init && terraform apply)


lint:
	tflint --init
	tflint --recursive --minimum-failure-severity=error
validate: global-validate stg-validate test-validate prod-validate


global-validate:
	$(call validate-task,global)
global-plan:
	$(call plan-task,global)
global-plan-apply:
	$(call plan-apply-task,global)
global-apply:
	$(call apply-task,global)

prod-validate:
	$(call validate-task,prod)
prod-plan:
	$(call plan-task,prod)
prod-plan-apply:
	$(call plan-apply-task,prod)
prod-apply:
	$(call apply-task,prod)

stg-validate:
	$(call validate-task,stg)
stg-plan:
	$(call plan-task,stg)
stg-plan-apply:
	$(call plan-apply-task,stg)
stg-apply:
	$(call apply-task,stg)

test-validate:
	$(call validate-task,test)
test-plan:
	$(call plan-task,test)
test-plan-apply:
	$(call plan-apply-task,test)
test-apply:
	$(call apply-task,test)
