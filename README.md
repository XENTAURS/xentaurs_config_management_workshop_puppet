Recipe Name
=========

This is an example Xentaurs workshop project for Puppet, Vagrant, Puppet-Rspec, and ServerSpec integration

Dependencies
----------------

* Install RVM

        \curl -sSL https://get.rvm.io | bash
* Install Ruby 2.2

        rvm install ruby-2.2
* Use RVM to use ruby 2.2

        rvm use ruby-2.2
* Install Bundle Gem

        gem install bundle
* Install Gems

        bundle install
* Install Vagrant (https://www.vagrantup.com/docs/installation/)
* Install VirtualBox (https://www.virtualbox.org/wiki/Downloads)

Rake Commands
----------------

## Rake Commands

### puppet-lint

[puppet-lint](http://puppet-lint.com/) allows the Puppet module developer to statically check that the content of their Puppet code conforms to the Puppet style standard. It checks for trailing whitespace, indentation and tabs, and many other Puppet style guidelines as listed [here](http://puppet-lint.com/checks/). With puppet-lint checking for unconformity, it's a lot easier for a team of Puppet developers to adhere to a general style guideline.

Example:
    % bundle exec rake lint
      manifests/client.pp - WARNING: class not documented on line 1
      manifests/crowsnest.pp - WARNING: class not documented on line 1
      manifests/params.pp - WARNING: top-scope variable being used without an explicit namespace on line 3
      manifests/params.pp - WARNING: class not documented on line 1
      manifests/params.pp - ERROR: trailing whitespace found on line 21
      ...

### rspec-puppet

[rspec-puppet](http://rspec-puppet.com/) allows the Puppet module developer to write [RSpec](https://relishapp.com/rspec) unit tests for their Puppet code.

This Puppet module directory will have a subdirectory called 'spec' with a directory tree as follows:

    spec
    ├── spec/classes
    │   └── spec/classes/ntp_spec.rb
    ├── spec/defines
    ├── spec/fixtures
    │   ├── spec/fixtures/manifests
    │   │   └── spec/fixtures/manifests/site.pp
    │   └── spec/fixtures/modules
    │       └── spec/fixtures/modules/ntp
    │           ├── spec/fixtures/modules/ntp/files -> ../../../../files
    │           ├── spec/fixtures/modules/ntp/lib
    │           │   └── spec/fixtures/modules/ntp/lib/puppet
    │           │       └── spec/fixtures/modules/ntp/lib/puppet/parser
    │           │           └── spec/fixtures/modules/ntp/lib/puppet/parser/functions
    │           │               └── spec/fixtures/modules/ntp/lib/puppet/parser/functions/zabbix_registration.rb
    │           ├── spec/fixtures/modules/ntp/manifests -> ../../../../manifests
    │           └── spec/fixtures/modules/ntp/templates -> ../../../../templates
    ├── spec/functions
    ├── spec/hosts
    ├── spec/spec_helper.rb
    └── spec/unit

All rspec-puppet tests for Puppet classes should be written in the 'spec/classes/MODULE_spec.rb' file.

All rspec-puppet tests for Puppet define types should be written in the 'spec/defines/MODULE_spec.rb' file.

As you can see above there are numerous files underneath the 'spec' subdirectory. A lot of these files - especially the files under 'spec/fixtures' - exist to glue together our RSpec testing tools. The 'spec/fixtures' directory is unique in that all module dependencies, including the module being developed, should be found under the 'spec/fixtures' directory. rspec-puppet, serverspec, and vagrant will all make use of this special 'spec/fixtures' directory.

In order to add additional module dependencies into your Puppet module, this example provides a .fixtures.yml file which can be modified to add additional Puppet modules to your project. The default .fixtures.yml file will look like the following:

    fixtures:
    # repositories:
    #   stdlib: 'git://github.com/puppetlabs/puppetlabs-stdlib'
      symlinks:
        ntp/files: '../../../../files'
        ntp/manifests: '../../../../manifests'
        ntp/templates: '../../../../templates'

As you can see, additional modules - like 'stdlib' - can be added to your Puppet module project directory.
#### Running rspec-puppet tests

    % bundle exec rake unit
    HEAD is now at 44c181e Merge branch 'fix/master/add_recursive_merge'
    /Users/ttc/.rvm/rubies/ruby-2.1.1/bin/ruby -S rspec spec/classes/config_spec.rb spec/classes/install_spec.rb spec/classes/ntp_spec.rb spec/classes/service_spec.rb --color
    ........

    Finished in 0.53874 seconds
    8 examples, 0 failures

For more details about rspec-puppet and how to write the actual rspec-puppet tests, please check the [project website](http://rspec-puppet.com/).

### serverspec

[serverspec](http://serverspec.org/) allows the Puppet module developer to write [RSpec](https://relishapp.com/rspec) integration tests for their Puppet code. serverspec integration tests work in conjunction with [vagrant](http://www.vagrantup.com/) and allow a Puppet developer the ability to quickly provision a vagrant virtual box Linux system and then run these tests against this live system.

This Puppet module directory will have a subdirectory called 'serverspec' with a directory tree as follows:

    serverspec
    ├── serverspec/spec
    │   └── serverspec/spec/MODULE_spec.rb
    └── serverspec/spec_helper.rb

ll serverspec tests should be written in the 'serverspec/spec/MODULE_spec.rb' file.

#### Running serverspec tests

    % bundle exec rake integ
    HEAD is now at 44c181e Merge branch 'fix/master/add_recursive_merge'

    Running integration tests on Vagrant image; this will take a few moments...

    /Users/ttc/.rvm/rubies/ruby-2.1.1/bin/ruby -S rspec serverspec/spec/ntp_spec.rb --color
    ................

    Finished in 48.7 seconds
    16 examples, 0 failures

For more details about serverspec and how to write the actual serverspec tests, please check the [project website](http://serverspec.org/).

### vagrant

[vagrant](http://vagrantup.com) allows the Puppet developer to start local VirtualBox instances in their Puppet module project and provision the instance with the Puppet module being tested. vagrant requires a Vagrantfile which specifies how to launch a VirtualBox instance. This example sets up the required Vagrantfile with the proper configurations required to start the VirtualBox VM (w/ 'vagrant up') and provision the instance with the module being tested.

This example also has a .vagrant_puppet/ directory in your Puppet module project and more importantly a .vagrant_puppet/init.pp file containing the necessary configuration for Puppet provisioning your VirtualBox instance. The Puppet module developer should change the .vagrant_puppet/init.pp file to provision their VirtualBox instance according to their needs. The best way to understand this is to take a look at some of the Puppet module examples below.

During the development of a Puppet module, the Puppet module developer can run 'vagrant provision' to continuously test their Puppet module changes. The developer can login to the VirtualBox instance (w/ 'vagrant ssh') and check the state of their Puppet provisioning.

NOTE: vagrant does NOT implicitly re-provision your VirtualBox instance each time. Only on a new VirtualBox instance creation will VirtualBox automatically run a 'provision' for you. The Puppet module developer should run 'vagrant provision' each time they need to check their latest Puppet code changes.

For more details about vagrant, please check the [project website](http://www.vagrantup.com/).

License
-------

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Author Information
------------------

Brian Carpio
bcarpio@xentaurs.com

Created By Magnum
------------------

https://github.com/bcarpio/magnum
