## Development

### System dependencies (Ubuntu 14.04 package names)
- build-essential
- postgresql-server-dev-9.3

*NOTE:* The version of postgresql may vary accordingly with your system version

### Ruby version
`2.3.1`

You can easily install it through the Ruby Version Manager - RVM. Instructions on how to do it can be found at http://rvm.io

It is expected to work with:

- 2.1.5 Debian 8
- 2.0.0 CentOS 7

*NOTE:* If you are using the gnome-shell, or any derivative like terminator, you have to mark on your profile the option to use a "login bash".


### Configuration

    ./bin/setup

This will create all the configuration files with defaults for Ubuntu and initialize your database.

### How to run the test suite

    rake

### Deployment instructions

Deployment is made through Capistrano (https://github.com/capistrano/capistrano)

    cap production deploy

In order to do this, you must have your ssh key set at the target server.

Otherwise, you can also modify the deployment file at <tt>config/deploy.rb</tt>.

#### First Deploy

  1. Make sure that the deployment files (<tt>config/deploy.rb</tt> <tt>config/deploy/production.rb</tt> are correctly configured to the installation server);
  2. Also, make sure that the installation server already has rvm installed;
    - It should already have the ruby version installed with the gemset created as well
  3. Check if everything is OK for deploy:
      `cap production deploy:check`
  4. Finally deploy with:
      `cap production deploy`
