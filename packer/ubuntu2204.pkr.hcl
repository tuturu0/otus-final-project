source "yandex" "ubuntu22" {
  service_account_key_file = var.service_account_key_file
  folder_id                = var.folder_id
  source_image_family      = "ubuntu-2204-lts"
  image_name               = "ubuntu2204-${formatdate("MM-DD-YYYY", timestamp())}"
  image_family             = "ubuntu"
  ssh_username             = "ubuntu"
  platform_id              = "standard-v1"
  use_ipv4_nat             = "true"
  zone                     = "ru-central1-a"
}

build {
  sources = ["source.yandex.ubuntu22"]

  provisioner "shell" {
    name            = "ssh"
    script          = "./configure.sh"
    execute_command = "sudo {{.Path}}"
  }
}
