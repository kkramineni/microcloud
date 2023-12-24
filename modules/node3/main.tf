resource "null_resource" "micro-03" {

    connection {
      user = "kishore"
      password = "VMware1!"
      host = "micro-03.cloudbricks.local"
    }
    
    provisioner "remote-exec" {
      inline = [ 
        "sudo apt-get update",
        "sudo snap refresh",
        "sudo snap install lxd microceph microcloud microovn --cohort=\"+\"",
        "sudo snap refresh lxd --channel=latest/stable"
       ]
    }
  
}