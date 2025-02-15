resource "aws_iam_instance_profile" "asg_profile"{
    name = "asg-profile"
    role = aws_iam_role.asg_role.name
}

resource "aws_launch_template" "app" {
  name = "app-template"

  iam_instance_profile {
    name = aws_iam_instance_profile.asg_profile.name
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 20
      volume_type = "gp2"
    }
  }

  image_id      = "ami-036c2987dfef867fb"
  instance_type = "t2.micro"

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF
  )

  vpc_security_group_ids = [aws_security_group.asg_sg.id]
}

resource "aws_autoscaling_group" "app" {
  desired_capacity     = 2
  max_size             = 6
  min_size             = 2
  vpc_zone_identifier  = values(module.vpc_nfw.private_subnets)
  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "app-instance"
    propagate_at_launch = true
  }
}