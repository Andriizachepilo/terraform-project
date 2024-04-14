resource "aws_dynamodb_table" "example" {
  for_each      = var.table_name

  name          = each.value
  billing_mode  = "PAY_PER_REQUEST"

  hash_key       = var.hash_key_name[each.key]  
  attribute {
    name = var.hash_key_name[each.key] 
    type = var.hash_key_type[each.key]  
  }
}
