This repository contains some useful Vault configurations.

1.  /Packer - config files for generating a single server Vault AMI
    Instructions:
    1.  git clone https://github.com/brijean/vault.git
    2.  Edit variables in vault.pkr.hcl as necessary
    3.  setup  environment variables for AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY - 
    4.  run packer build ./vault.pkr.hcl

