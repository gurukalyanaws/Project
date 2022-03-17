Welcome,

This is just a sample terraform file to launch servers in different availablity zones

The launched instances will be having java, jenkins, maven installations

To check thier versions:
java --version;
service jenkins status;
/opt/maven/bin/mvn -v.

To execute the terraform files:

terraform init;
terraform plan;
terraform apply.
