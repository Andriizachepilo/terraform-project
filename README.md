# Terraform project

![A hero starting their journey looking at a tower](./media/images/journey.png "A hero starting their journey looking at a tower")

So far we have encountered a lot of different pieces of the Terraform journey in separation. This project will require you to bring together all the knowledge you have acquired over these past 2 weeks, in a complex infrastructure.

Your project tasks will be delivered via the L2C platform.

You can find this sprint [here.](https://l2c.northcoders.com/courses/ce-provisioning/terraform-project)

## Requirements

The target for this project is to create a hosted network of microservices that mocks a smart home network with; a central status service, a lighting service, heating service, and authorisation service.

This concept may feel very familiar but we have tweaked some of the services and they now use AWS services for data storage.

## Tearing things down

You should run `terraform destroy` to remove everything at the end of each day, if you've created your code well it should be able to recreate each time without issue.

## Further reading

[Terraform directory structure tips](https://xebia.com/blog/four-tips-to-better-structure-terraform-projects/)

[Terraform best practices structure](https://www.terraform-best-practices.com/examples/terraform)
