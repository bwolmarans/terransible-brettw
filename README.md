So the original terransible project is from many years ago, using old, outdated versions of aws linux, php, mysql, wordpress, ansible, and terraform.  but it's still an amazing body of work and I encourage anyone to go look at it closely.  

What I have done here is swap out the old aws linux ami for a t2 micro bitname that already had wordpress, then added into ansible a probably superflous line to restart the bitnami services.

the rest, the wholse s3 /var/www/html bucket copy and scaling group and 5 second cron job to pull is as per OP.

here is a run example:

root@kali:/home/ec2-user/terransible# terraform apply
random_id.golden_ami: Refreshing state... [id=L6mwFhqyfq8]
random_id.wp_code_bucket: Refreshing state... [id=CUc]
aws_instance.wp_dev: Refreshing state...
data.aws_availability_zones.available: Refreshing state...
aws_instance.wp_dev: Refreshing state...
aws_s3_bucket.code: Refreshing state... [id=scruffybrett-2375]
aws_vpc.wp_vpc: Refreshing state... [id=vpc-0c2f25bd7ec679d6a]
aws_route53_zone.primary: Refreshing state... [id=Z2JXZ0CA30LPWQ]
aws_key_pair.wp_auth: Refreshing state... [id=blah]
aws_instance.wp_dev: Refreshing state...
aws_iam_role.s3_access_role: Refreshing state... [id=s3_access_role]
aws_instance.wp_dev: Refreshing state...
aws_iam_instance_profile.s3_access_profile: Refreshing state... [id=s3_access]
aws_iam_role_policy.s3_access_policy: Refreshing state... [id=s3_access_role:s3_access_policy]
aws_subnet.wp_rds2_subnet: Refreshing state... [id=subnet-059b19beeae2eeabb]
aws_security_group.wp_public_sg: Refreshing state... [id=sg-06ee1ae75a5eda40c]
aws_subnet.wp_public1_subnet: Refreshing state... [id=subnet-05cb45b74e0e8ca33]
aws_subnet.wp_rds1_subnet: Refreshing state... [id=subnet-092be5fc196d6e4a4]
aws_subnet.wp_private1_subnet: Refreshing state... [id=subnet-01c64e2712bd3c55d]
aws_route53_zone.secondary: Refreshing state... [id=Z01334361NDTI907V3W3V]
aws_security_group.wp_dev_sg: Refreshing state... [id=sg-076224e5115c8802c]
aws_default_route_table.wp_private_rt: Refreshing state... [id=rtb-092b95b5648712503]
aws_subnet.wp_public2_subnet: Refreshing state... [id=subnet-0171529a4d619172e]
aws_security_group.wp_private_sg: Refreshing state... [id=sg-0c17e6b6adb6a8a12]
aws_subnet.wp_rds3_subnet: Refreshing state... [id=subnet-013d990d3c21345e2]
aws_subnet.wp_private2_subnet: Refreshing state... [id=subnet-0dbdb582f203db5a3]
aws_internet_gateway.wp_internet_gateway: Refreshing state... [id=igw-09c667268598b8a16]
aws_instance.wp_dev: Refreshing state... [id=i-044b6f53218689cdb]
aws_security_group.wp_rds_sg: Refreshing state... [id=sg-0d7984888782bc733]
aws_elb.wp_elb: Refreshing state... [id=scruffybrett-elb]
aws_route_table_association.wp_private1_assoc: Refreshing state... [id=rtbassoc-0b3b5e77a59e2016b]
aws_db_subnet_group.wp_rds_subnetgroup: Refreshing state... [id=wp_rds_subnetgroup]
aws_route_table.wp_public_rt: Refreshing state... [id=rtb-0ff6624eedd4e57de]
aws_route_table_association.wp_private2_assoc: Refreshing state... [id=rtbassoc-0abd0b7a55ca6ecf0]
aws_route_table_association.wp_public_assoc: Refreshing state... [id=rtbassoc-077402216e6d306fa]
aws_route_table_association.wp_public2_assoc: Refreshing state... [id=rtbassoc-03ad5fd1544676ea3]
aws_vpc_endpoint.wp_private-s3_endpoint: Refreshing state... [id=vpce-08656137a831f2351]
aws_db_instance.wp_db: Refreshing state... [id=terraform-20200101042844949000000003]
aws_route53_record.www: Refreshing state... [id=Z2JXZ0CA30LPWQ_www.scruffybrett.com_A]
aws_route53_record.db: Refreshing state... [id=Z01334361NDTI907V3W3V_db.scruffybrett.com_CNAME]
aws_ami_from_instance.wp_golden: Refreshing state... [id=ami-00eb54b29ca552000]
aws_route53_record.dev: Refreshing state... [id=Z2JXZ0CA30LPWQ_dev.scruffybrett.com_A]

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create
  ~ update in-place

Terraform will perform the following actions:

  # aws_autoscaling_group.wp_asg will be created
  + resource "aws_autoscaling_group" "wp_asg" {
      + arn                       = (known after apply)
      + availability_zones        = (known after apply)
      + default_cooldown          = (known after apply)
      + desired_capacity          = 2
      + force_delete              = true
      + health_check_grace_period = 300
      + health_check_type         = "EC2"
      + id                        = (known after apply)
      + launch_configuration      = (known after apply)
      + load_balancers            = [
          + "scruffybrett-elb",
        ]
      + max_size                  = 2
      + metrics_granularity       = "1Minute"
      + min_size                  = 1
      + name                      = (known after apply)
      + protect_from_scale_in     = false
      + service_linked_role_arn   = (known after apply)
      + target_group_arns         = (known after apply)
      + vpc_zone_identifier       = [
          + "subnet-01c64e2712bd3c55d",
          + "subnet-0dbdb582f203db5a3",
        ]
      + wait_for_capacity_timeout = "10m"
    }

  # aws_launch_configuration.wp_lc will be created
  + resource "aws_launch_configuration" "wp_lc" {
      + associate_public_ip_address = false
      + ebs_optimized               = (known after apply)
      + enable_monitoring           = true
      + iam_instance_profile        = "s3_access"
      + id                          = (known after apply)
      + image_id                    = "ami-00eb54b29ca552000"
      + instance_type               = "t2.micro"
      + key_name                    = "blah"
      + name                        = (known after apply)
      + name_prefix                 = "wp_lc-"
      + security_groups             = [
          + "sg-0c17e6b6adb6a8a12",
        ]
      + user_data                   = "6adec3f1b4dc0cb9ed599e5b921bd939425f6b51"

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + no_device             = (known after apply)
          + snapshot_id           = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_vpc_endpoint.wp_private-s3_endpoint will be updated in-place
  ~ resource "aws_vpc_endpoint" "wp_private-s3_endpoint" {
        cidr_blocks           = [
            "54.231.0.0/17",
            "52.216.0.0/15",
        ]
        dns_entry             = []
        id                    = "vpce-08656137a831f2351"
        network_interface_ids = []
        owner_id              = "058625519174"
      ~ policy                = jsonencode(
          ~ {
                Statement = [
                    {
                        Action    = "*"
                        Effect    = "Allow"
                        Principal = "*"
                        Resource  = "*"
                    },
                ]
              - Version   = "2008-10-17" -> null
            }
        )
        prefix_list_id        = "pl-63a5400a"
        private_dns_enabled   = false
        requester_managed     = false
        route_table_ids       = [
            "rtb-092b95b5648712503",
            "rtb-0ff6624eedd4e57de",
        ]
        security_group_ids    = []
        service_name          = "com.amazonaws.us-east-1.s3"
        state                 = "available"
        subnet_ids            = []
        tags                  = {}
        vpc_endpoint_type     = "Gateway"
        vpc_id                = "vpc-0c2f25bd7ec679d6a"
    }

Plan: 2 to add, 1 to change, 0 to destroy.


Warning: Interpolation-only expressions are deprecated

  on main.tf line 2, in provider "aws":
   2:   region  = "${var.aws_region}"

Terraform 0.11 and earlier required all non-constant expressions to be
provided via interpolation syntax, but this pattern is now deprecated. To
silence this warning, remove the "${ sequence from the start and the }"
sequence from the end of this expression, leaving just the inner expression.

Template interpolation syntax is still used to construct strings from
expressions when the template includes multiple interpolation sequences or a
mixture of literal strings and interpolations. This deprecation applies only
to templates that consist entirely of a single interpolation sequence.

(and 77 more similar warnings elsewhere)


Warning: Value for undeclared variable

  on terraform.tfvars line 34:
  34: test                    = {}

The root module does not declare a variable named "test". To use this value,
add a "variable" block to the configuration.

Using a variables file to set an undeclared variable is deprecated and will
become an error in a future release. If you wish to provide certain "global"
settings to all configurations in your organization, use TF_VAR_...
environment variables to set these instead.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_launch_configuration.wp_lc: Creating...
aws_vpc_endpoint.wp_private-s3_endpoint: Modifying... [id=vpce-08656137a831f2351]
aws_launch_configuration.wp_lc: Creation complete after 1s [id=wp_lc-20200101044919508400000001]
aws_autoscaling_group.wp_asg: Creating...
aws_vpc_endpoint.wp_private-s3_endpoint: Modifications complete after 6s [id=vpce-08656137a831f2351]
aws_autoscaling_group.wp_asg: Still creating... [10s elapsed]
aws_autoscaling_group.wp_asg: Still creating... [20s elapsed]
aws_autoscaling_group.wp_asg: Still creating... [30s elapsed]
aws_autoscaling_group.wp_asg: Creation complete after 37s [id=asg-wp_lc-20200101044919508400000001]

Apply complete! Resources: 2 added, 1 changed, 0 destroyed.
root@kali:/home/ec2-user/terransible#
