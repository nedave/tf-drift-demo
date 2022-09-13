resource "aws_security_group" "ccs_drift_demo" {

  name        = "ccs_drift_demo"
  description = "Security group for CCS drift detection demo"
  vpc_id      = "vpc-00e7e47a"

  ingress {
    self      = false
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/16",
      "192.168.1.0/24",
    ]
  }
  tags = {
    yor_trace = "a65b1f8b-55fb-4f60-a009-e2c79287a0c1"
  }
}