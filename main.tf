resource "aws_glue_crawler" "this" {
  database_name = var.database_name
  name          = var.name
  role = var.role

  s3_target {
    path = var.path
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