resource "aws_security_group" "ccs_drift_demo" {

  name        = "ccs_drift_demo"
  description = "Security group for CCS drift detection demo"
  vpc_id      = "vpc-0fa41465321d0e9d0"

  ingress {
    self      = false
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.10.0.0/16",
    ]
  }
  tags = {
    yor_trace = "a65b1f8b-55fb-4f60-a009-e2c79287a0c1"
  }
}