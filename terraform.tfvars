localip     = "3.91.87.117/32"
aws_profile = "terransible"
aws_region  = "us-east-1"
vpc_cidr    = "10.7.0.0/16"
cidrs = {
  public1  = "10.7.1.0/24"
  public2  = "10.7.2.0/24"
  private1 = "10.7.3.0/24"
  private2 = "10.7.4.0/24"
  rds1     = "10.7.5.0/24"
  rds2     = "10.7.6.0/24"
  rds3     = "10.7.7.0/24"
}
db_instance_class       = "db.t2.micro"
dbname                  = "superherodb"
dbuser                  = "superhero"
dbpassword              = "superheropass"
key_name                = "blah"
public_key_path         = "/home/ec2-user/.ssh/blah.pub"
domain_name             = "scruffybrett"
dev_instance_type       = "t2.micro"
dev_ami                 = "ami-02ba2e7a8c66dd5bd"
elb_healthy_threshold   = "2"
elb_unhealthy_threshold = "2"
elb_timeout             = "3"
elb_interval            = "30"
asg_max                 = "2"
asg_min                 = "1"
asg_grace               = "300"
asg_hct                 = "EC2"
asg_cap                 = "2"
lc_instance_type        = "t2.micro"
delegation_set          = "N15KD4GL2HQ7NI"
test                    = {}
