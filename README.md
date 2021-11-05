# scp-deployer

## DataONE version

This is a re-hosted version of scp-deployer, originally developed by siva1024 and released under the MIT license. This rehosted version allows DataONE to customize and securely deploy the image for allied projects.

## Required Parameters

- `host`: Remote Hostname
- `username`: Remote Host Username
- `port`: Remote Host SSH Port
- `key`: Remote Host SSH Private key
- `password`: Remote Host Password (If no SSH key is provided)
- `source`: Source files location
- `target`: Remote Host deployment location

## SSH Private/Public Key
Below is the command for generations of SSH keys. For the complete manual the location can be found [here](https://linux.die.net/man/1/ssh-keygen).
```
ssh-keygen -t rsa -b 4096
```
Generate and save the public key in the Remote Host at `~/.ssh/authorized_keys` location.

The Private keys can be saved in the [GIT Action Secretes](https://docs.github.com/en/actions/reference/encrypted-secrets) for better security.

## Example

Below is the sample .yml file templet for the SCP deployer

```yml
name: scp files
on: [push]
jobs:

  build:
    name: Build
    runs-on: ubuntu-latest
    steps:
    - name: Checkout repository
      uses: actions/checkout@v2    
    - name: Upload Files
      uses: dataone/scp-deployer@latest
      with:
        host: ${{ secrets.HOST }}
        username: ${{ secrets.USERNAME }}
        key: ${{ secrets.KEY }}
        source: "entrypoint.sh"
        target: "~/"
```
## Note
A special thanks to GitHub and Stack Overflow Community for providing all the support and open-source code. This code is specifically made for my requirements and I used a lot of references for my code. Please let me know if there are any issues and use my code as a templet if needed.
