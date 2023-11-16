# Terraform project

![A hero starting their journey looking at a tower](./media/images/journey.png "A hero starting their journey looking at a tower")

It is time to take those Terraform skills you have been developing and create your own project.

Time to start your journey and create a brand new Terraform project from scratch.

Side note: The image is what AI generated when the words "success, journey and terraform logo" were put into the tool 🤷

You can find the trello board to copy for your project below

[Cloud Ops Terraform Project Template](https://trello.com/b/ANaPDxTY/ce-terraform-project-template)

## Requirements

The target for this project is to create a hosted network of microservices that mocks a smart home network with; a central status service, a lighting service, and a heating service.

But that isn't everything....

Your solution should;

- Be completed using terraform
- Be a production ready network setup with both public and private subnets
- Make use of terraform variables and looping where possible
- Make your code as DRY and reusable as possible by creating modules where you can
- Have DynamoDB tables to account for the services that need them
- Be created with 'design for failure' in mind - we do not want a loss of service if one of the EC2 instances fails
- Be considerate and intentional of how your files and directory structures are named

[Here](https://trello.com/b/ANaPDxTY/ce-terraform-project-template) you will find a trello board with the tickets needed to finish this project.

## Tearing things down

You should run `terraform destroy` to remove everything at the end of each day, if you've created your code well it should be able to recreate each time without issue.

## Submission process

1. Fork this GitHub repository

2. Make a branch for each tickets code `git checkout -b NEW_BRANCH_NAME`

3. Create a Pull Request and merge the branch back into main on GitHub when the ticket is done

4. Submit the Pull Request link to `nchelp pr`

5. Checkout back to the main branch `git checkout main` and pull your code to the main branch `git pull origin main`

6. Create a new branch for the next ticket and repeat until finished.

## Further reading

[Terraform directory structure tips](https://xebia.com/blog/four-tips-to-better-structure-terraform-projects/)

[Terraform best practices structure](https://www.terraform-best-practices.com/examples/terraform)
