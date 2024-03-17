resource "null_resource" "run_script" {
  provisioner "local-exec" {
    command = "./instances_id.sh"
    working_dir = "${path.module}"
  }
}

# chmod +x instances_id.sh
