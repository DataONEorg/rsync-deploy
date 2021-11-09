# rsync deploy

Deploy files to a TARGET host using rsync by configuring an appropriate ssh KEY.

## Required Parameters

- `host`: Remote Hostname
- `username`: Remote Host Username
- `port`: Remote Host SSH Port
- `key`: Remote Host SSH Private key
- `source`: Source files location (rsync naming conventions)
- `target`: Remote Host deployment location (rsync naming conventions)

## SSH Private/Public Key
Below is the command for generation of SSH keys. For the complete manual the location can be found [here](https://linux.die.net/man/1/ssh-keygen).
```
ssh-keygen -t rsa -b 4096
```
Generate and save the public key on the Remote Host at `~/.ssh/authorized_keys` location.

The Private keys should be exposed to the workflow as [Action Secrets](https://docs.github.com/en/actions/reference/encrypted-secrets) for better security.

## Example

Below is a sample .yml file for rsync deploy:

```yml
name: rsync-deploy
on: [push]
jobs:

  build:
    name: Build
    runs-on: ubuntu-latest
    steps:
    - name: Checkout repository
      uses: actions/checkout@v2    
    - name: Upload Files
      uses: dataone/rsync-deploy@latest
      with:
        host: ${{ secrets.HOST }}
        username: ${{ secrets.USERNAME }}
        key: ${{ secrets.KEY }}
        source: "entrypoint.sh"
        target: "~/sometargetdir/"

## History

This is a refactored version of scp-deployer, originally developed by siva1024 and released under the MIT license. This refactored version allows DataONE to customize and securely deploy the image for allied projects, and uses rsync rather than scp.
## History

This is a refactored version of scp-deployer, originally developed by siva1024 and released under the MIT license. This refactored version allows DataONE to customize and securely deploy the image for allied projects, and uses rsync rather than scp.
