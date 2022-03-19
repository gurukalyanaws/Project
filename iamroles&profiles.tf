resource "aws_iam_role" "codedeploy_Role" {
  name = "Code_Deploy"
  description = "Role having S3 & CodeDeploy full access"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  managed_policy_arns   = [
        "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess",
        "arn:aws:iam::aws:policy/AmazonS3FullAccess",
  ]
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.codedeploy_Role.name
}