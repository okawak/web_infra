resource "oci_identity_compartment" "my_compartment" {
  name           = "compartment_for_webserver"
  description    = "My compartment for OCI resources"
  compartment_id = var.tenancy_ocid
}

resource "oci_core_vcn" "my_vcn" {
  cidr_block     = "10.0.0.0/16"
  display_name   = "vcn_for_webserver"
  compartment_id = oci_identity_compartment.my_compartment.id
}

resource "oci_core_subnet" "my_subnet" {
  cidr_block     = "10.0.1.0/24"
  vcn_id         = oci_core_vcn.my_vcn.id
  compartment_id = oci_identity_compartment.my_compartment.id
}

resource "oci_core_instance" "oraclelinux_instance" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.my_compartment.id
  shape               = "VM.Standard.E2.1.Micro"
  source_details {
    # oracle linux 9.x
    source_id   = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaaaice3ypyugajc75ikhtdxd3vbr3ikygors7lpifjwjqduebv7ulq"
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
