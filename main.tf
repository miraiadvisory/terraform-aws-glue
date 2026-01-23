resource "aws_glue_crawler" "this" {
  database_name = var.database_name
  name          = var.name
  role          = var.role

  s3_target {
    path        = var.path
    sample_size = 1
  }

  dynamic "recrawl_policy" {
    for_each = var.recrawl_behavior == null ? [] : [var.recrawl_behavior]
    content {
      recrawl_behavior = recrawl_policy.value
    }
  }

  schema_change_policy {
    update_behavior = var.schema_update_behavior
    delete_behavior = var.schema_delete_behavior
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
