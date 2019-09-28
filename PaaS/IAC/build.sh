# launch terraform to provision cluster  
docker run -it --rm \ 
    -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
    -v $(pwd):/go/src/github.com/hashicorp/terraform \
    -w /go/src/github.com/hashicorp/terraform \
    hashicorp/terraform:0.11.11 \
    destroy

# launch ansible to install & configure 
## kubernetes

## load balancer

## rancher
docker run --rm \
        -v $(pwd):/crv-ansible \
        -v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
        -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
        -w /crv-ansible \
        williamyeh/ansible:alpine3 \
        ansible-playbook -i production site.yml -vvv

## RKE