Welcome
=======

This is the HomeFinder.com starter application.

INSTALLATION INSTRUCTIONS
=========================

This is a Rails 3.2 app.  We have provided a Vagrant configuration to get you up and running
quickly.  The only dependency to use the vagrant environment is to have Vagrant (http://www.vagrantup.com/)
and VirtualBox (https://www.virtualbox.org/) installed.  You can also install the rails dpendancies
yourself if your prefer to go that route.

The following are steps to get the server running if using vagrant.  We assume you have already installed
the two dependancies. In the checked out repository do the following:

```
$ vagrant up (first time this is run may take a bit of time)
$ vagrant ssh 
$ cd /vagrant
$ bundle
$ rails server
```

You can now access the running rails server at http://localhost:3000.  You can edit files in the 
repository and they will be reflected in your browser with a refresh.

