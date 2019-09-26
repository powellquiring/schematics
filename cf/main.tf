variable ibmcloud_api_key {}
variable ssh_key_name {}
variable resource_group_name {}

variable "ibmcloud_timeout" {
  description = "Timeout for API operations in seconds."
  default     = 900
}

variable region {
  default = "us-south"
}

variable zone {
  default = "us-south-1"
}

variable "basename" {
  description = "Name for the VPC to create and prefix to use for all other resources."
  default     = "example"
}

#----------------------
variable "app_version" {
  default = "1"
}

variable "git_repo" {
  default = "https://github.com/IBM-Bluemix/nodejs-cloudantdb-crud-example"
}

variable "dir_to_clone" {
  default = "/tmp/my_cf_code"
}

variable "app_zip" {
  default = "/tmp/myzip.zip"
}

#----------------------


provider ibm {
  region           = "${var.region}"
  ibmcloud_api_key = "${var.ibmcloud_api_key}"
  ibmcloud_timeout = "${var.ibmcloud_timeout}"
  generation       = 1                         # vpc on classic
}

resource "null_resource" "prepare_app_zip" {
  triggers = {
    app_version = "${var.app_version}"
    git_repo = "${var.git_repo}"
  }
  provisioner "local-exec" {
    command = <<EOF
        set -x
        ls -lisa
        ibmcloud plugin list
        curl
        wget
        apt update
        mkdir -p ${var.dir_to_clone}
        cd ${var.dir_to_clone}
        git init
        git remote add origin ${var.git_repo}
        git fetch
        git checkout -t origin/master
        zip -r ${var.app_zip} *
        ls -lisa /
        ls -lisa /tmp
        env
        EOF
  }
}
