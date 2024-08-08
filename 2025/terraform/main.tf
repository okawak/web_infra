resource "oci_core_instance" "oraclelinux_instance" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.my_compartment.id
  shape               = "VM.Standard.E2.1.Micro"
  source_details {
    # oracle linux 9.x
    source_id = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaaurwkfdqqwkwxm5t65jnjhh7vrn2uqgxqggk7drrodk56frxfj36a"
    # oracle linux 8.x
    # source_id   = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaa4imi7idv6a4xcado5sno5xrajab7wsef5p5pa53bnkloc2zeoqeq"
    source_type = "image"
  }

  display_name = "okawak_webserver"
  create_vnic_details {
    assign_public_ip = true
    subnet_id        = oci_core_subnet.my_subnet.id
  }
  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
  }
  preserve_boot_volume = false
}
