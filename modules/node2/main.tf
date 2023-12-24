resource "null_resource" "micro-02" {

    connection {
      user = "kishore"
      password = "VMware1!"
      host = "micro-02.cloudbricks.local"
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