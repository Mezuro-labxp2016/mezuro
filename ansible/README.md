### What is this repository?

This is a basic initial setup to start hacking into Mezuro

#### How does it work?

It starts a virtual machine using Vagrant and installs everything necessary to start working on Mezuro

#### How can I run it?

You will need Vagrant, Python and Ansible installed.

Start the VM and run the ansible playbook on it in order to install all the dependencies and clone the repositories.

```
vagrant up
ansible-playbook site.yml
```
