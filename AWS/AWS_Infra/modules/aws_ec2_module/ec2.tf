resource "aws_lb_target_group" "aws_load_balancer" {
  name     = "aws_load_balancer${terraform.workspace}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}

resource "aws_launch_configuration" "launch_configuration" {
  name_prefix     = "launch_configuration-${terraform.workspace}"
  image_id        = var.ubuntu-ami
  instance_type   = "t2.micro"
  user_data       = file("user-data.sh")
  security_groups = [aws_security_group.terramino_instance.id]

  lifecycle {
    create_before_destroy = true
  }
}