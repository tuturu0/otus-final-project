terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.95.0"
    }
  }
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}


resource "yandex_compute_instance" "ubuntu" {

  count = var.vm_count

  name = "ubuntu-vm${count.index + 1}"

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашем задании
      image_id = var.image_id
    }
  }

  network_interface {
    # Указан id подсети default-ru-central1-a
    subnet_id = var.subnet_id
    nat       = true
  }

  provisioner "remote-exec" {
    inline = ["echo ready!"]
  }

  connection {
    type  = "ssh"
    #host  = yandex_compute_instance.app[*].network_interface.0.nat_ip_address
    host  = self.network_interface.0.nat_ip_address
    user  = "application"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }

}
