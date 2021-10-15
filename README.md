<!-- [![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=linaro-its_aws2-wrap&metric=alert_status)](https://sonarcloud.io/dashboard?id=linaro-its_aws2-wrap) -->

# aws-sso-cred-restore
This is script is inspired from `aws2-wrap` and solve problem with old sdk's  like aws-sdk-go and turn safe our
work with tools like terraform.

## the problem

Work with terraform is more safe if we use only profile configuration and  work with `workspaces` feature.

```hcl
provider "aws" {
	 profile = "${terraform.env}"
	 region  = "${var.region}"
}
```

But aws sso cli command cannot configure credentials file, and aws-sdk-go cannot work with new model of profile config.

Using environment variables, the configuration overwrite profile option on provider block on terraform, and this is *dangerous*.

This wrapper solve `temporary` (hello aws and hashicorp, solve this plis!!) this problem.


## Install using `pip`

https://pypi.org/project/aws-sso-cred-restore

`pip install aws-sso-cred-restore==<VERSION>`

## Install using a docker image

* Clone this repo
* Build the image (inside the project dir): `docker build -t aws-sso-cred-restore:v1 . `
* (Optional) create an alias to use: `alias awsrestore='docker container run -it -v ~/.aws/:/root/.aws aws-sso-cred-restore:v1'`
* To use, just execute: `awsrestore`

## Run a command using AWS SSO credentials

`aws-sso-cred-restore --profile <awsprofilename-or-prefix>`

or run to all profiles in your config

`aws-sso-cred-restore`

This command will get credentials using active aws sso access key section file
and restore in `~/.aws/credentials`


## Export the credentials

There may be circumstances when it is easier/better to set the appropriate environment variables so that they can be re-used by any `aws` command.

Since the script cannot directly set the environment variables in the calling shell process, it is necessary to use the following syntax:

`eval "$(aws-sso-cred-restore --profile <awsprofilename-or-prefix> --export)"`

