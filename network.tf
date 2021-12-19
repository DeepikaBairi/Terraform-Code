resource "aws_security_group" "WebDMZ"{
 name = "WebDMZ"
 vpc_id = "vpc-680a610f"
 ingress {
     description = "Web Access"
     from_port = 80
     to_port = 80
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
     description = "SSH Access"
     from_port = 22
     to_port = 22
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
 }
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "Webtier"{
 name = "Webtier"
 vpc_id = "vpc-680a610f" 
 ingress {
     description = "Web Access"
     from_port = 80
     to_port = 80
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
     description = "SSH Access"
     from_port = 22
     to_port = 22
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
 }
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "RDSSecurityGroup"{
 name = "RDSSecurityGroup"
 vpc_id = "vpc-680a610f"
 ingress {
     description = "RDS Access"
     from_port = 3306
     to_port = 3306
     protocol = "tcp"
     cidr_blocks = []
     security_groups = ["sg-004cb02d13a5c667f"]
 }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource aws_lb_target_group "MyWPTG"{
    name = "MyWPTG"
    port = 80
    protocol = "HTTP"
    vpc_id = "vpc-680a610f"
    target_type = "instance"
    health_check {
      enabled = true
      healthy_threshold = 2
      interval = 6
      matcher = 200
      path = "/index.html"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 2
      unhealthy_threshold = 2
      
        }
}
resource aws_lb_target_group_attachment "WebServer1"{
target_group_arn = "arn:aws:elasticloadbalancing:ap-southeast-1:061335423113:targetgroup/MyWPTG/db433c70472082e0"
target_id = "i-0b33ad4d1abd0c0a9"
port = 80
}
resource aws_lb_target_group_attachment "WebServer2"{
target_group_arn = "arn:aws:elasticloadbalancing:ap-southeast-1:061335423113:targetgroup/MyWPTG/db433c70472082e0"
target_id = "i-00e439f44764c72e0"
port = 80
}
resource aws_lb "MYALB"{
    name = "MYALB"
    load_balancer_type = "application"
    internal = false
    security_groups = ["sg-04787e19771fec9b3"]
    subnets = ["subnet-5f53b206", "subnet-bb7459dc","subnet-f699cbbf"]
    }
     
resource aws_lb_listener "MYALB"{
    load_balancer_arn = "arn:aws:elasticloadbalancing:ap-southeast-1:061335423113:loadbalancer/app/MYALB/fdada0c46120b1fd"
    port = 80
    protocol = "HTTP"
default_action {
      type = "forward"
      target_group_arn = "arn:aws:elasticloadbalancing:ap-southeast-1:061335423113:targetgroup/MyWPTG/db433c70472082e0"
    }

}

##Application ALB##
resource aws_lb_target_group "AppWPTG"{
    name = "AppWPTG"
    port = 80
    protocol = "HTTP"
    vpc_id = "vpc-680a610f"
    target_type = "instance"
    health_check {
      enabled = true
      healthy_threshold = 2
      interval = 6
      matcher = 200
      path = "/healthy.html"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 2
      unhealthy_threshold = 2
      
        }
}
resource aws_lb_target_group_attachment "WordPressServer1"{
target_group_arn = "arn:aws:elasticloadbalancing:ap-southeast-1:061335423113:targetgroup/AppWPTG/6001ab2f816a5330"
target_id = "i-0a60d9f84ec21fd65"
port = 80
}
resource aws_lb_target_group_attachment "WordPressServer2"{
target_group_arn = "arn:aws:elasticloadbalancing:ap-southeast-1:061335423113:targetgroup/AppWPTG/6001ab2f816a5330"
target_id = "i-03afe6ee29923f0ec"
port = 80
}
resource aws_lb "MyAppALB"{
    name = "MYAMyAppALBB"
    load_balancer_type = "application"
    internal = false
    security_groups = ["sg-04787e19771fec9b3"]
    subnets = ["subnet-5f53b206", "subnet-bb7459dc","subnet-f699cbbf"]
    }
     
resource aws_lb_listener "MyAppALB"{
    load_balancer_arn = "arn:aws:elasticloadbalancing:ap-southeast-1:061335423113:loadbalancer/app/MyAppALB/dc382fe0a4cae5c7"
    port = 80
    protocol = "HTTP"
default_action {
      type = "forward"
      target_group_arn = "arn:aws:elasticloadbalancing:ap-southeast-1:061335423113:targetgroup/AppWPTG/6001ab2f816a5330"
    }

}
