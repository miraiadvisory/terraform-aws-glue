resource "aws_glue_crawler" "this" {
  database_name = var.database_name
  name          = var.name
  role          = var.role

  s3_target {
    path = var.path
  }

  dynamic "recrawl_policy" {
    for_each = var.recrawl_behavior == null ? [] : [var.recrawl_behavior]
    content {
      recrawl_behavior = recrawl_policy.value
    }
  }

  provisioner "local-exec" {
    command = "aws glue start-crawler --name ${self.name} --region ${var.region}"
  }

  configuration = <<EOF
{
 "Version":1.0,
 "Grouping": {
   "TableGroupingPolicy": "CombineCompatibleSchemas"
 }
}
EOF
}
