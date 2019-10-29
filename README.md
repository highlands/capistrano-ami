# Capistrano AMI

[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE.txt)

This plugin that create AMI (Amazon Machine Image) and manage generations
tasks into capistrano script. `capistrano-ami` tasks are able to run when
deploy target servers exists in AWS (http://aws.amazon.com/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-ami', git: 'https://github.com/highlands/capistrano-ami'
```

And then execute:

    $ bundle

## Usage
Load `capistrano-ami` into your capistrano configuration file `Capfile`:
```ruby
require 'capistrano/ami'
```
And set config values in deploy script `config/deploy.rb`:
```ruby
set :aws_region, 'us-east-1'       # deploy servers region name
set :instance_id, 'i-abcd1234'     # instance id of the ec2 instance you wish to create an AMI of default is nil
set :base_ami_name, 'web-role'     # name: "#{base_ami_name}_#{instance_id}_#{deploy_timestamp}" default is capistrano-ami
set :keep_amis, 3                  # number of AMIs to keep. default is 5
```

### Credentials

`capistrano-ami` supports various credential providers. As of the following
priority:

- Specified shared credentials
- Key values
- Environment values
- Default shared credentials
- IAM role

#### Key values

You can set credentials in the deploy script `config/deploy.rb`:
```ruby
set :aws_access_key_id, 'YOUR_AWS_ACCESS_KEY'
set :aws_region, 'YOUR_AWS_REGION'
set :aws_secret_access_key, 'YOUR_AWS_SECRET_KEY'
```

#### Environment values

`capistrano-ami` looks at `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, and
`AWS_REGION` environemt values.
```
$ export AWS_ACCESS_KEY_ID=YOUR_AWS_ACCESS_KEY
$ export AWS_REGION=YOUR_AWS_REGION
$ export AWS_SECRET_ACCESS_KEY=YOUR_AWS_SECRET_KEY
```

#### Shared credentials

Shared credentials are credentials file in local machine. default location is
`~/.aws/credentials`. [More infomation](https://blogs.aws.amazon.com/security/post/Tx3D6U6WSFGOK2H/A-New-and-Standardized-Way-to-Manage-Credentials-in-the-AWS-SDKs).
If you want to use `default`, do not specify key values in delopy script. But
if you want to use other profile, you should specify following:

```ruby
set :aws_credentials_profile_name, 'profile_name'
```

#### IAM role

IAM role is most secure credential provider. If you can, should use this.
[More infomation](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html).
This provider used in no credentials configuration. Because you should not
specify key values.

## Versions

We check working this plugin following platform versions.

- Ruby
    - 2.3.0
- Capistrano
    - 3.5.0

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/highlands/capistrano-ami. This project is intended to be a
safe, welcoming space for collaboration, and contributors are expected to
adhere to the [Contributor Covenant](http://contributor-covenant.org) code of
conduct.

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).
