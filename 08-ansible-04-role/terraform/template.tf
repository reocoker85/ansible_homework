
data "template_file" "inventory" {
   template = "${file("hosts")}"

    vars = {

             clickhouse_ip = "${yandex_compute_instance.vm["clickhouse"].network_interface.0.nat_ip_address}"
             vector_ip = "${yandex_compute_instance.vm["vector"].network_interface.0.nat_ip_address}"
             lighthouse_ip = "${yandex_compute_instance.vm["lighthouse"].network_interface.0.nat_ip_address}"
    }
}

resource "null_resource" "update_inventory" {

    triggers = {
        template = "${data.template_file.inventory.rendered}"
    }

    provisioner "local-exec" {
        command = "echo '${data.template_file.inventory.rendered}' > /home/vagrant/ansible_homework/08-ansible-03-yandex/playbook/inventory/prod.yml"
    }
}
