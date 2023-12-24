resource "null_resource" "Microcloud-init" {

    connection {
      user = "kishore"
      password = "VMware1!"
      host = "micro-01.cloudbricks.local"
    }

    provisioner "file" {
      source = "/opt/code/tofu/microcloud/modules/micro_init/preseed.yaml"
      destination = "/tmp/preseed.yaml"
    }

    provisioner "remote-exec" {
      inline = [ 
        "cat /tmp/preseed.yaml | sudo microcloud init --preseed",
        "sudo snap set lxd ui.enable=true",
        "sudo systemctl reload snap.lxd.daemon"
       ]
    }
  
}