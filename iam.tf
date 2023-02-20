####################     TASK EXCUTION ROLE POLICY ########################

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = [var.iam_actions]

    principals {
      type        = var.principle_type
      identifiers = [var.principle_identifiers]
    }
  }
}

resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "${var.prefix}-ecstaskexcutionrole"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}


resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = var.policy_arn
}
