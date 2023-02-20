#################   ECR   ############################

resource "aws_ecr_repository" "ecr-repo" {
  name                 = "${var.prefix}"
  image_tag_mutability = var.ecr_img_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.ecr_img_sacn_on_push
  }
}

resource "aws_ecr_repository_policy" "repo-policy" {
  repository = aws_ecr_repository.ecr-repo.name
  policy     = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "adds full ecr access to the demo repository",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetLifecyclePolicy",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
      }
    ]
  }
  EOF
}