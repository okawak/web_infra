resource "oci_core_instance" "oraclelinux_instance" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.my_compartment.id
  display_name        = "okawak_webserver"

  #shape = "VM.Standard2.1"
  shape = "VM.Standard.E3.Flex"
  shape_config {
    ocpus         = 1
    memory_in_gbs = 2
  }

  source_details {
    # oracle linux 9.x
    source_id   = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaaurwkfdqqwkwxm5t65jnjhh7vrn2uqgxqggk7drrodk56frxfj36a"
    source_type = "image"
  }

  create_vnic_details {
    assign_public_ip = true
    subnet_id        = oci_core_subnet.my_subnet.id
  }
  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
  }
  preserve_boot_volume = false
}
