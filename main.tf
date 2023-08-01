locals {
  crds_url = "https://raw.githubusercontent.com/Patrick1982/terraform-crds-management"
  crds_tag = "v3.0.0"
  crds_folder = "crds"
  crds_names = [
    "example-1.yaml",
    "example-2.yaml",
    "example-3.yaml",
    "example-4.yaml",
    "serviceAccount.yaml",
  ]
  crds_documents = flatten([
    for file in local.crds_names :
    [
      for index, document in data.kubectl_file_documents.crd[file].documents :
      {
        file    = file 
        index   = index
        yaml    = document
      }
    ]
  ])
}

#data "kubectl_path_documents" "docs" {
#    pattern = "./crds/*.yaml"
#}
#
#resource "kubectl_manifest" "test" {
#    for_each  = toset(data.kubectl_path_documents.docs.documents)
#    yaml_body = each.value
#     force_new = false 
#}

data "http" "crds_file" {
  for_each = toset(local.crds_names)
  url = "${local.crds_url}/${local.crds_tag}/${local.crds_folder}/${each.value}"
}

data "kubectl_file_documents" "crd" {
    for_each = toset(local.crds_names)
    content = data.http.crds_file["${each.value}"].response_body
}

resource "kubectl_manifest" "crd" {
  for_each = { for idx, file_data in local.crds_documents : idx => file_data }
  yaml_body = each.value.yaml
}

#data "http" "crds_file" {
#  #  for_each = toset(local.crds_file_names)
#  #url = "https://raw.githubusercontent.com/Patrick1982/terraform-dynamic-files/master/crds/${each.value}"
#  url = "https://raw.githubusercontent.com/Patrick1982/terraform-dynamic-files/master/crds/example-2-v1.yaml"
#}
#
#data "kubectl_file_documents" "velero_crd" {
#    content = data.http.crds_file.response_body 
#}
#
#resource "kubectl_manifest" "velero_crd" {
#  for_each = toset(data.kubectl_file_documents.velero_crd.documents)
#  yaml_body = each.value 
#}

#resource "null_resource" "test" {
#  provisioner "local-exec" {
#    command = "echo ${data.http.crds_file.response_body} >> private_ips.txt"
#  }
#}

#resource "null_resource" "downloaded_yamls" {
#  for_each = toset(local.downloaded_yamls)
#
#  provisioner "local-exec" {
#    command = format("echo Archivo: %s", each.value.body)
#  }
#}

#output "downloaded_yaml_contents" {
#  value = data.kubectl_file_documents.velero_crd
#}
