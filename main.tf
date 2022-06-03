###################################################################################
#                 DATABASE COMPUTE INSTANCE (VM) and Attached Disks               #
###################################################################################

// Create disks
resource "google_compute_disk" "database_disk" {
  for_each = var.disk_configs

  name    = format("${var.compute_instance_name}-disk-%s", lower(each.key))
  project = var.project_id
  type    = each.value.type
  zone    = var.zone
  size    = each.value.size
  labels  = merge(var.labels, { drive-letter = lower(each.key), purpose = "ms-sql" })
}

// Attach drive letters to VMs
resource "google_compute_attached_disk" "database_attached_disk" {
  for_each = var.disk_configs

  project  = var.project_id
  disk     = google_compute_disk.database_disk[each.key].self_link
  instance = google_compute_instance.database_VM.self_link
}

// Create database VM
resource "google_compute_instance" "database_VM" {
  name         = var.compute_instance_name
  project      = var.project_id
  machine_type = var.machine_type
  zone         = var.zone

  scheduling {
    automatic_restart   = var.automatic_restart
    on_host_maintenance = var.on_host_maintenance
  }

  tags = var.tags

  boot_disk {
    initialize_params {
      image = var.image_name
      size  = var.db_size
      type  = var.db_type
    }
  }

  network_interface {
    subnetwork = var.subnetwork
    network_ip = var.network_ip

    # Support one or more alias IP ranges
    alias_ip_range {
        ip_cidr_range = var.alias_ip_ranges
      }
  }
  
  lifecycle {
    ignore_changes = [attached_disk]
  }

  metadata = {
    serial-port-enable            = false              ### In general make sure serial console is unavailable - sec issue
    sysprep-specialize-script-ps1 = var.sysprep_script ### sysprep script to create user for initial setup
  }

  allow_stopping_for_update = var.allow_stopping_for_update

  service_account {
    email  = var.service_account_email
    scopes = ["cloud-platform"]
  }

  labels = var.labels
}
