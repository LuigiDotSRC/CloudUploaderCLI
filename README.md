# CloudUploaderCLI

A CLI tool that can upload files to Azure Storage Accounts. Built using bash and Azure's CLI. 

![Demo screenshot](./assets/demo.png)

## Setup

1. Must have Azure CLI installed. https://learn.microsoft.com/en-us/cli/azure/install-azure-cli
2. Create an Azure Storage Account.
3. Configure the .env file at the root of this project with the following values: 
    ```
    SUBSCRIPTION_ID= 
    ACCOUNT_NAME=
    AZURE_STORAGE_KEY=
    ```
4. Ensure that ~/bin is a part of $PATH by running: `echo $PATH`
5. Run `installer.sh` 
    - **NOTE: .env values will be copied to ~/bin/.clouduploaderconfig**
    - Alternatively, you can run `clouduploader.sh` locally from the project directory. Ensure proper permissions with `sudo chmod +x clouduploader.sh`
6. Now ready to run the command `clouduploader` on the CLI!
